enum AuthIdentityProvider {
  guest,
  google,
  apple,
}

enum AuthConflictResolution {
  keepCurrentDeviceData,
  useSavedAccountData,
}

enum AuthSignInStatus {
  success,
  cancelled,
  requiresResolution,
  failed,
}

class AuthSession {
  final String workspaceKey;
  final bool isGuest;
  final AuthIdentityProvider provider;
  final String? email;
  final String? displayName;

  const AuthSession({
    required this.workspaceKey,
    required this.isGuest,
    required this.provider,
    this.email,
    this.displayName,
  });
}

class AuthWorkspaceConflict {
  final String sourceWorkspaceKey;
  final String targetWorkspaceKey;
  final AuthIdentityProvider provider;

  const AuthWorkspaceConflict({
    required this.sourceWorkspaceKey,
    required this.targetWorkspaceKey,
    required this.provider,
  });
}

class AuthSignInResult {
  final AuthSignInStatus status;
  final AuthWorkspaceConflict? conflict;
  final Object? error;

  const AuthSignInResult._({
    required this.status,
    this.conflict,
    this.error,
  });

  const AuthSignInResult.success()
      : this._(status: AuthSignInStatus.success);

  const AuthSignInResult.cancelled()
      : this._(status: AuthSignInStatus.cancelled);

  const AuthSignInResult.requiresResolution(AuthWorkspaceConflict conflict)
      : this._(
          status: AuthSignInStatus.requiresResolution,
          conflict: conflict,
        );

  const AuthSignInResult.failed(Object error)
      : this._(
          status: AuthSignInStatus.failed,
          error: error,
        );
}
