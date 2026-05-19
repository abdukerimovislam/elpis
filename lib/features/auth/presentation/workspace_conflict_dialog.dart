import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/auth_session.dart';

Future<AuthConflictResolution?> showWorkspaceConflictDialog(
  BuildContext context,
) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<AuthConflictResolution>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.authConflictTitle),
      content: Text(l10n.authConflictBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            AuthConflictResolution.useSavedAccountData,
          ),
          child: Text(l10n.authConflictUseAccount),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            AuthConflictResolution.keepCurrentDeviceData,
          ),
          child: Text(l10n.authConflictUseDevice),
        ),
      ],
    ),
  );
}
