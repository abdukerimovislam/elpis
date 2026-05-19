import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../domain/auth_session.dart';
import 'workspace_manager.dart';

const _entryChoiceCompletedKey = 'auth_entry_choice_completed_v1';
const _legacyWorkspaceImportedKey = 'legacy_workspace_imported_v1';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final authSessionRepositoryProvider =
    FutureProvider<AuthSessionRepository>((ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  final repository = AuthSessionRepository(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
    workspaceManager: ref.watch(workspaceManagerProvider),
    preferences: preferences,
  );
  ref.onDispose(repository.dispose);
  return repository;
});

final authBootstrapProvider = FutureProvider<void>((ref) async {
  final repository = await ref.watch(authSessionRepositoryProvider.future);
  await repository.ensureInitialized();
});

final authSessionProvider = StreamProvider<AuthSession>((ref) async* {
  await ref.watch(authBootstrapProvider.future);
  final repository = await ref.watch(authSessionRepositoryProvider.future);
  yield* repository.watchSession();
});

final entryChoiceCompletedProvider = StreamProvider<bool>((ref) async* {
  final repository = await ref.watch(authSessionRepositoryProvider.future);
  yield* repository.watchEntryChoice();
});

final activeWorkspaceDirectoryProvider = FutureProvider<String>((ref) async {
  final session = await ref.watch(authSessionProvider.future);
  final manager = ref.watch(workspaceManagerProvider);
  return manager.workspaceDirectoryFor(session.workspaceKey);
});

class AuthSessionRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final WorkspaceManager _workspaceManager;
  final SharedPreferences _preferences;
  final StreamController<bool> _entryChoiceController =
      StreamController<bool>.broadcast();

  Future<void>? _bootstrapFuture;
  bool _entryChoiceCompleted;

  AuthSessionRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required WorkspaceManager workspaceManager,
    required SharedPreferences preferences,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _workspaceManager = workspaceManager,
        _preferences = preferences,
        _entryChoiceCompleted =
            preferences.getBool(_entryChoiceCompletedKey) ?? false;

  Future<void> ensureInitialized() {
    return _bootstrapFuture ??= _performBootstrap();
  }

  Stream<AuthSession> watchSession() async* {
    await ensureInitialized();
    yield* _auth.authStateChanges().asyncMap((user) async {
      final resolvedUser = user ?? await _ensureFirebaseUser();
      return _sessionFromUser(resolvedUser);
    });
  }

  Stream<bool> watchEntryChoice() async* {
    yield _entryChoiceCompleted;
    yield* _entryChoiceController.stream.distinct();
  }

  Future<void> continueAsGuest() async {
    await ensureInitialized();
    final currentUser = _auth.currentUser;
    if (currentUser == null || !currentUser.isAnonymous) {
      await signOutToGuest();
      return;
    }
    await _setEntryChoiceCompleted(true);
  }

  Future<void> signOutToGuest() async {
    await ensureInitialized();
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Google session may not exist on this device; Firebase sign-out is enough.
    }
    await _auth.signOut();
    await _ensureFirebaseUser();
    await _setEntryChoiceCompleted(true);
  }

  Future<AuthSignInResult> signInWithGoogle() async {
    await ensureInitialized();

    try {
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) {
        return const AuthSignInResult.cancelled();
      }

      final googleAuth = await googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return _authenticateWithCredential(
        credential,
        provider: AuthIdentityProvider.google,
      );
    } catch (error) {
      return AuthSignInResult.failed(error);
    }
  }

  Future<AuthSignInResult> signInWithApple() async {
    await ensureInitialized();

    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256OfString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      return _authenticateWithCredential(
        credential,
        provider: AuthIdentityProvider.apple,
      );
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code == AuthorizationErrorCode.canceled) {
        return const AuthSignInResult.cancelled();
      }
      return AuthSignInResult.failed(error);
    } catch (error) {
      return AuthSignInResult.failed(error);
    }
  }

  Future<void> resolveWorkspaceConflict(
    AuthWorkspaceConflict conflict,
    AuthConflictResolution resolution,
  ) async {
    if (resolution == AuthConflictResolution.keepCurrentDeviceData) {
      await _workspaceManager.replaceWorkspaceData(
        sourceKey: conflict.sourceWorkspaceKey,
        targetKey: conflict.targetWorkspaceKey,
      );
    }
    await _setEntryChoiceCompleted(true);
  }

  void dispose() {
    _entryChoiceController.close();
  }

  Future<void> _performBootstrap() async {
    final user = await _ensureFirebaseUser();
    final didImportLegacyData = await _maybeImportLegacyWorkspace(user.uid);
    if (didImportLegacyData) {
      await _setEntryChoiceCompleted(true);
      return;
    }

    if (!_entryChoiceCompleted) {
      if (!user.isAnonymous ||
          await _workspaceManager.workspaceHasMeaningfulData(user.uid)) {
        await _setEntryChoiceCompleted(true);
      }
    }
  }

  Future<User> _ensureFirebaseUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser;
    }
    final credential = await _auth.signInAnonymously();
    final user = credential.user;
    if (user == null) {
      throw StateError('Firebase anonymous session could not be created.');
    }
    return user;
  }

  Future<bool> _maybeImportLegacyWorkspace(String targetWorkspaceKey) async {
    final alreadyImported =
        _preferences.getBool(_legacyWorkspaceImportedKey) ?? false;
    if (alreadyImported) {
      return false;
    }

    final hasLegacyData = await _workspaceManager.legacyWorkspaceHasMeaningfulData();
    if (!hasLegacyData) {
      await _preferences.setBool(_legacyWorkspaceImportedKey, true);
      return false;
    }

    final targetHasData =
        await _workspaceManager.workspaceHasMeaningfulData(targetWorkspaceKey);
    if (!targetHasData) {
      await _workspaceManager.importLegacyWorkspaceInto(targetWorkspaceKey);
    }

    await _preferences.setBool(_legacyWorkspaceImportedKey, true);
    await _workspaceManager.closeLegacyWorkspace();
    return true;
  }

  Future<AuthSignInResult> _authenticateWithCredential(
    AuthCredential credential, {
    required AuthIdentityProvider provider,
  }) async {
    final currentUser = await _ensureFirebaseUser();
    final sourceWorkspaceKey = currentUser.uid;
    final sourceWasGuest = currentUser.isAnonymous;

    try {
      if (sourceWasGuest) {
        await currentUser.linkWithCredential(credential);
        await _setEntryChoiceCompleted(true);
        return const AuthSignInResult.success();
      }

      await _auth.signInWithCredential(credential);
      await _setEntryChoiceCompleted(true);
      return const AuthSignInResult.success();
    } on FirebaseAuthException catch (error) {
      final canRecoverFromExistingCredential =
          error.code == 'credential-already-in-use' ||
              error.code == 'email-already-in-use' ||
              error.code == 'account-exists-with-different-credential';

      if (!sourceWasGuest || !canRecoverFromExistingCredential) {
        return AuthSignInResult.failed(error);
      }

      try {
        final signInResult = await _auth.signInWithCredential(credential);
        final targetUser = signInResult.user;
        if (targetUser == null) {
          return AuthSignInResult.failed(
            StateError('Firebase did not return a signed-in user.'),
          );
        }

        final sourceHasData =
            await _workspaceManager.workspaceHasMeaningfulData(sourceWorkspaceKey);
        final targetHasData =
            await _workspaceManager.workspaceHasMeaningfulData(targetUser.uid);

        if (!sourceHasData) {
          await _setEntryChoiceCompleted(true);
          return const AuthSignInResult.success();
        }

        if (!targetHasData) {
          await _workspaceManager.replaceWorkspaceData(
            sourceKey: sourceWorkspaceKey,
            targetKey: targetUser.uid,
          );
          await _setEntryChoiceCompleted(true);
          return const AuthSignInResult.success();
        }

        return AuthSignInResult.requiresResolution(
          AuthWorkspaceConflict(
            sourceWorkspaceKey: sourceWorkspaceKey,
            targetWorkspaceKey: targetUser.uid,
            provider: provider,
          ),
        );
      } catch (secondaryError) {
        return AuthSignInResult.failed(secondaryError);
      }
    } catch (error) {
      return AuthSignInResult.failed(error);
    }
  }

  Future<void> _setEntryChoiceCompleted(bool value) async {
    _entryChoiceCompleted = value;
    await _preferences.setBool(_entryChoiceCompletedKey, value);
    if (!_entryChoiceController.isClosed) {
      _entryChoiceController.add(value);
    }
  }

  AuthSession _sessionFromUser(User user) {
    final provider = _providerFromUser(user);
    return AuthSession(
      workspaceKey: user.uid,
      isGuest: user.isAnonymous,
      provider: provider,
      email: user.email,
      displayName: user.displayName,
    );
  }

  AuthIdentityProvider _providerFromUser(User user) {
    if (user.isAnonymous) {
      return AuthIdentityProvider.guest;
    }

    for (final info in user.providerData) {
      switch (info.providerId) {
        case 'google.com':
          return AuthIdentityProvider.google;
        case 'apple.com':
          return AuthIdentityProvider.apple;
      }
    }

    return AuthIdentityProvider.guest;
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256OfString(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
