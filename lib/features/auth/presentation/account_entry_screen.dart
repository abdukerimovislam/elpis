import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/holographic_background.dart';
import '../../../l10n/app_localizations.dart';
import '../data/auth_session_repository.dart';
import '../domain/auth_session.dart';
import 'workspace_conflict_dialog.dart';

class AccountEntryScreen extends ConsumerStatefulWidget {
  const AccountEntryScreen({super.key});

  @override
  ConsumerState<AccountEntryScreen> createState() => _AccountEntryScreenState();
}

class _AccountEntryScreenState extends ConsumerState<AccountEntryScreen> {
  AuthIdentityProvider? _pendingProvider;
  bool _continuingAsGuest = false;

  bool get _isBusy => _pendingProvider != null || _continuingAsGuest;

  Future<void> _continueAsGuest() async {
    if (_isBusy) {
      return;
    }

    setState(() => _continuingAsGuest = true);
    try {
      final repository = await ref.read(authSessionRepositoryProvider.future);
      await repository.continueAsGuest();
    } catch (error) {
      if (!mounted) {
        return;
      }
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.authSignInError}: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _continuingAsGuest = false);
      }
    }
  }

  Future<void> _signIn(AuthIdentityProvider provider) async {
    if (_isBusy) {
      return;
    }

    setState(() => _pendingProvider = provider);
    try {
      final repository = await ref.read(authSessionRepositoryProvider.future);
      final result = switch (provider) {
        AuthIdentityProvider.google => await repository.signInWithGoogle(),
        AuthIdentityProvider.apple => await repository.signInWithApple(),
        AuthIdentityProvider.guest => const AuthSignInResult.cancelled(),
      };
      await _handleSignInResult(repository, result);
    } finally {
      if (mounted) {
        setState(() => _pendingProvider = null);
      }
    }
  }

  Future<void> _handleSignInResult(
    AuthSessionRepository repository,
    AuthSignInResult result,
  ) async {
    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    switch (result.status) {
      case AuthSignInStatus.success:
      case AuthSignInStatus.cancelled:
        return;
      case AuthSignInStatus.requiresResolution:
        final resolution = await showWorkspaceConflictDialog(context);
        if (resolution != null && result.conflict != null) {
          await repository.resolveWorkspaceConflict(result.conflict!, resolution);
        }
        return;
      case AuthSignInStatus.failed:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.authSignInError}: ${result.error}')),
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.elpisColors;

    return Scaffold(
      backgroundColor: colors.milky,
      body: Stack(
        children: [
          const HolographicBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.84),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: colors.dustyRose.withValues(alpha: 0.12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.lavender.withValues(alpha: 0.12),
                          blurRadius: 34,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: colors.lavender.withValues(alpha: 0.16),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: colors.dustyRose,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          l10n.authEntryTitle,
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.authEntryBody,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _AuthButton(
                          label: l10n.authGoogleContinue,
                          icon: Icons.language_rounded,
                          isBusy: _pendingProvider == AuthIdentityProvider.google,
                          onPressed: () => _signIn(AuthIdentityProvider.google),
                        ),
                        if (Platform.isIOS || Platform.isMacOS) ...[
                          const SizedBox(height: 12),
                          _AuthButton(
                            label: l10n.authAppleContinue,
                            icon: Icons.apple_rounded,
                            isBusy:
                                _pendingProvider == AuthIdentityProvider.apple,
                            onPressed: () => _signIn(AuthIdentityProvider.apple),
                          ),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: _isBusy ? null : _continueAsGuest,
                            child: _continuingAsGuest
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colors.textBrown,
                                    ),
                                  )
                                : Text(l10n.authGuestContinue),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.authEntryHint,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isBusy;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.label,
    required this.icon,
    required this.isBusy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).elpisColors;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isBusy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: colors.dustyRose,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        icon: isBusy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(icon),
        label: Text(label),
      ),
    );
  }
}
