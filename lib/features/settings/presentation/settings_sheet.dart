import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_session_repository.dart';
import '../../auth/domain/auth_session.dart';
import '../../auth/presentation/workspace_conflict_dialog.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../reports/services/pdf_report_service.dart';

class SettingsSheet extends ConsumerStatefulWidget {
  final PregnancySettings currentSettings;

  const SettingsSheet({
    super.key,
    required this.currentSettings,
  });

  @override
  ConsumerState<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends ConsumerState<SettingsSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _momNameController;
  late final TextEditingController _partnerNameController;
  late final TextEditingController _partnerPhoneController;
  late final TextEditingController _doctorPhoneController;
  late final TextEditingController _hospitalAddressController;

  late DateTime _pickerDate;
  late String _languageCode;
  late String _visualModeKey;
  late bool _showLaborButton;
  late bool _notifyWeekly;
  late bool _notifyVitamins;
  late bool _notifyWater;

  bool _isExporting = false;
  bool _isSavingFields = false;
  bool _isDeletingData = false;
  bool _isAuthActionInProgress = false;

  @override
  void initState() {
    super.initState();
    final settings = widget.currentSettings;

    _nameController = TextEditingController(text: settings.babyName);
    _momNameController = TextEditingController(text: settings.momName);
    _partnerNameController = TextEditingController(text: settings.partnerName);
    _partnerPhoneController = TextEditingController(text: settings.partnerPhone);
    _doctorPhoneController = TextEditingController(text: settings.doctorPhone);
    _hospitalAddressController =
        TextEditingController(text: settings.hospitalAddress);

    _pickerDate = settings.estimatedDueDate.subtract(const Duration(days: 280));
    _languageCode = settings.languageCode;
    _visualModeKey = settings.effectiveVisualModeKey;
    _showLaborButton = settings.showLaborButton;
    _notifyWeekly = settings.notifyWeekly;
    _notifyVitamins = settings.notifyVitamins;
    _notifyWater = settings.notifyWater;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _momNameController.dispose();
    _partnerNameController.dispose();
    _partnerPhoneController.dispose();
    _doctorPhoneController.dispose();
    _hospitalAddressController.dispose();
    super.dispose();
  }

  DateTime get _finalDueDate => _pickerDate.add(const Duration(days: 280));

  int get _previewWeek {
    final now = DateTime.now();
    final conceptionDate = _finalDueDate.subtract(const Duration(days: 280));
    final difference = now.difference(conceptionDate);
    final week = (difference.inDays / 7).floor() + 1;
    if (week < 1) return 1;
    if (week > 42) return 42;
    return week;
  }

  String _profileValue(String value, String fallback) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? fallback : trimmed;
  }

  void _showErrorSnack(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _showSuccessSnack(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<bool> _safeRun(Future<void> Function() action) async {
    try {
      await action();
      return true;
    } catch (error, stack) {
      debugPrint('Settings Error: $error\n$stack');
      if (!mounted) return false;
      final l10n = AppLocalizations.of(context)!;
      _showErrorSnack('${l10n.errorGeneric}: $error');
      return false;
    }
  }

  Future<bool> _saveAllFields({bool showFeedback = false}) async {
    if (_isSavingFields) return false;

    setState(() => _isSavingFields = true);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            name: _nameController.text.trim(),
            momName: _momNameController.text.trim().isNotEmpty
                ? _momNameController.text.trim()
                : null,
            partnerName: _partnerNameController.text.trim(),
            partnerPhone: _partnerPhoneController.text.trim(),
            doctorPhone: _doctorPhoneController.text.trim(),
            hospitalAddress: _hospitalAddressController.text.trim(),
          );
    });

    if (mounted) {
      setState(() => _isSavingFields = false);
      if (didSave && showFeedback) {
        _showSuccessSnack(AppLocalizations.of(context)!.settingsChangesSaved);
      }
    }

    return didSave;
  }

  Future<void> _handleClose() async {
    final didSave = await _saveAllFields();
    if (!mounted || !didSave) return;
    Navigator.of(context).pop();
  }

  Future<void> _updateLanguage(String code) async {
    if (_languageCode == code) return;

    final previous = _languageCode;
    setState(() => _languageCode = code);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            languageCode: code,
          );
    });
    if (!didSave && mounted) {
      setState(() => _languageCode = previous);
    }
  }

  Future<void> _updateMode(String visualModeKey) async {
    if (_visualModeKey == visualModeKey) return;

    final previous = _visualModeKey;
    setState(() => _visualModeKey = visualModeKey);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).setVisualMode(visualModeKey);
    });
    if (!didSave && mounted) {
      setState(() => _visualModeKey = previous);
    }
  }

  Future<void> _updateLaborButtonVisibility(bool value) async {
    final previous = _showLaborButton;
    setState(() => _showLaborButton = value);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            showLaborButton: value,
          );
    });
    if (!didSave && mounted) {
      setState(() => _showLaborButton = previous);
    }
  }

  Future<void> _updateNotifyWeekly(bool value) async {
    final previous = _notifyWeekly;
    setState(() => _notifyWeekly = value);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            notifyWeekly: value,
          );
    });
    if (!didSave && mounted) {
      setState(() => _notifyWeekly = previous);
    }
  }

  Future<void> _updateNotifyVitamins(bool value) async {
    final previous = _notifyVitamins;
    setState(() => _notifyVitamins = value);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            notifyVitamins: value,
          );
    });
    if (!didSave && mounted) {
      setState(() => _notifyVitamins = previous);
    }
  }

  Future<void> _updateNotifyWater(bool value) async {
    final previous = _notifyWater;
    setState(() => _notifyWater = value);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            notifyWater: value,
          );
    });
    if (!didSave && mounted) {
      setState(() => _notifyWater = previous);
    }
  }

  Future<void> _pickDate() async {
    final nowRaw = DateTime.now();
    final today = DateTime(nowRaw.year, nowRaw.month, nowRaw.day);
    final maxDate = today.add(const Duration(days: 1));
    final minDate = today.subtract(const Duration(days: 320));

    final picked = await showDatePicker(
      context: context,
      initialDate: _pickerDate.isAfter(maxDate) ? maxDate : _pickerDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).elpisColors.dustyRose,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    final previous = _pickerDate;
    setState(() => _pickerDate = picked);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).saveDueDate(_finalDueDate);
    });
    if (!didSave && mounted) {
      setState(() => _pickerDate = previous);
    }
  }

  Future<void> _signInWithProvider(AuthIdentityProvider provider) async {
    if (_isAuthActionInProgress) return;

    setState(() => _isAuthActionInProgress = true);
    try {
      final repository = await ref.read(authSessionRepositoryProvider.future);
      final result = switch (provider) {
        AuthIdentityProvider.google => await repository.signInWithGoogle(),
        AuthIdentityProvider.apple => await repository.signInWithApple(),
        AuthIdentityProvider.guest => const AuthSignInResult.cancelled(),
      };

      if (!mounted) return;

      final l10n = AppLocalizations.of(context)!;
      switch (result.status) {
        case AuthSignInStatus.success:
          Navigator.of(context).pop();
          return;
        case AuthSignInStatus.cancelled:
          return;
        case AuthSignInStatus.requiresResolution:
          final resolution = await showWorkspaceConflictDialog(context);
          if (resolution != null && result.conflict != null) {
            await repository.resolveWorkspaceConflict(
              result.conflict!,
              resolution,
            );
            if (mounted) {
              Navigator.of(context).pop();
            }
          }
          return;
        case AuthSignInStatus.failed:
          _showErrorSnack('${l10n.authSignInError}: ${result.error}');
          return;
      }
    } finally {
      if (mounted) {
        setState(() => _isAuthActionInProgress = false);
      }
    }
  }

  Future<void> _switchToGuest() async {
    if (_isAuthActionInProgress) return;

    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.authSwitchToGuestTitle),
        content: Text(l10n.authSwitchToGuestBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.authSwitchToGuestAction),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isAuthActionInProgress = true);
    try {
      final repository = await ref.read(authSessionRepositoryProvider.future);
      await repository.signOutToGuest();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      _showErrorSnack('${l10n.authSignInError}: $error');
    } finally {
      if (mounted) {
        setState(() => _isAuthActionInProgress = false);
      }
    }
  }

  Future<void> _exportPdf() async {
    if (_isExporting) return;

    final saved = await _saveAllFields();
    if (!saved) return;

    setState(() => _isExporting = true);

    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    try {
      final repo = ref.read(pregnancyRepositoryProvider);
      final settings = await repo.getSettings();
      final weights = await repo.getWeights();
      final kickHistory = await repo.getKickHistory();
      final recentSymptoms = await repo.getRecentSymptoms();

      final reportData = ReportData(
        userName: _nameController.text.isNotEmpty
            ? _nameController.text
            : l10n.defaultMomName,
        currentWeek:
            settings?.currentWeek ?? widget.currentSettings.currentWeek,
        weightHistory:
            weights.map((item) => WeightEntry(item.date, item.weightKg ?? 0)).toList(),
        kickHistory: kickHistory
            .map((item) => KickSession(item.date, 0, item.totalKicks))
            .toList(),
        recentSymptoms: recentSymptoms,
      );

      final pdfBytes =
          await PdfReportService().generateReport(reportData, locale, l10n);
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: '${l10n.pdfFilePrefix}.pdf',
      );
    } catch (error) {
      debugPrint('PDF Error: $error');
      _showErrorSnack(l10n.errorGenericRetry);
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  void _wipeData() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.settingsDeleteData),
        content: Text(l10n.settingsDeleteDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () async {
              if (_isDeletingData) return;

              if (mounted) {
                setState(() => _isDeletingData = true);
              }

              try {
                await ref.read(pregnancyRepositoryProvider).clearAllData();
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (mounted) {
                  Navigator.of(context).pop();
                }
              } catch (error) {
                debugPrint('Wipe Error: $error');
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                _showErrorSnack(l10n.errorDeleteData);
              } finally {
                if (mounted) {
                  setState(() => _isDeletingData = false);
                }
              }
            },
            child: Text(
              l10n.commonDelete,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyUnavailable() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsPrivacy),
        content: Text(
          l10n.privacyUnavailable,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonUnderstood),
          ),
        ],
      ),
    );
  }

  void _showDisclaimer() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsDisclaimer),
        content: SingleChildScrollView(
          child: Text(l10n.disclaimerBody),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonUnderstood),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ec = theme.elpisColors;
    final locale = Localizations.localeOf(context).toString();
    final authSessionAsync = ref.watch(authSessionProvider);
    final heroMomName =
        _profileValue(_momNameController.text, l10n.defaultMomName);
    final heroBabyName = _profileValue(_nameController.text, '—');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.94,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom + 18,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ec.milky,
              Colors.white,
              ec.lightBeige.withValues(alpha: 0.82),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 46,
              height: 5,
              decoration: BoxDecoration(
                color: ec.textBrown.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            _SettingsHeader(
              title: l10n.settingsTitle,
              subtitle: l10n.settingsOverviewBody,
              onClose: _isSavingFields ? null : _handleClose,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OverviewCard(
                      title: l10n.settingsOverviewTitle,
                      momName: heroMomName,
                      babyName: heroBabyName,
                      currentWeek: _previewWeek,
                      dueDate: DateFormat.yMMMMd(locale).format(_finalDueDate),
                      helper: l10n.settingsSaveHelper,
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.badge_outlined,
                      title: l10n.settingsProfileTitle,
                      subtitle: l10n.settingsProfileBody,
                      accent: ec.peach,
                      child: Column(
                        children: [
                          _InputBlock(
                            label: l10n.onboardingMomNameLabel,
                            child: _SettingsInputField(
                              controller: _momNameController,
                              hint: l10n.onboardingMomNameHint,
                              onChanged: (_) => setState(() {}),
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InputBlock(
                            label: l10n.settingsNameLabel,
                            child: _SettingsInputField(
                              controller: _nameController,
                              hint: l10n.settingsNameHint,
                              onChanged: (_) => setState(() {}),
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _DateCard(
                            title: l10n.onboardingEddLabel,
                            value: DateFormat.yMMMMd(locale).format(_finalDueDate),
                            supporting:
                                '${l10n.onboardingLmpLabel}: ${DateFormat.yMMMd(locale).format(_pickerDate)}',
                            onTap: _pickDate,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.tune_rounded,
                      title: l10n.settingsPreferencesTitle,
                      subtitle: l10n.settingsPreferencesBody,
                      accent: ec.lavender,
                      child: Column(
                        children: [
                          _MiniSectionLabel(label: l10n.languageLabel),
                          const SizedBox(height: 10),
                          _SegmentRow<String>(
                            value: _languageCode,
                            options: [
                              _SegmentOption(
                                value: 'ru',
                                title: l10n.languageRussian,
                              ),
                              _SegmentOption(
                                value: 'en',
                                title: l10n.languageEnglish,
                              ),
                            ],
                            onChanged: _updateLanguage,
                          ),
                          const SizedBox(height: 18),
                          _MiniSectionLabel(label: l10n.mode),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _VisualModeCard(
                                  label: l10n.settingsModeFruit,
                                  icon: Icons.apple_rounded,
                                  isSelected: _visualModeKey ==
                                      PregnancySettings.visualModeFruit,
                                  onTap: () => _updateMode(
                                    PregnancySettings.visualModeFruit,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _VisualModeCard(
                                  label: l10n.settingsModeRealistic,
                                  icon: Icons.auto_awesome_rounded,
                                  isSelected: _visualModeKey ==
                                      PregnancySettings.visualModeRealistic,
                                  onTap: () => _updateMode(
                                    PregnancySettings.visualModeRealistic,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _VisualModeCard(
                                  label: l10n.weekNavGrowth,
                                  icon: Icons.child_care_rounded,
                                  isSelected: _visualModeKey ==
                                      PregnancySettings.visualModeGrowth,
                                  onTap: () => _updateMode(
                                    PregnancySettings.visualModeGrowth,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          _MiniSectionLabel(label: l10n.settingsNotificationsTitle),
                          const SizedBox(height: 6),
                          _ToggleTile(
                            title: l10n.settingsNotifyWeekly,
                            onChanged: _updateNotifyWeekly,
                            value: _notifyWeekly,
                          ),
                          _ToggleTile(
                            title: l10n.settingsNotifyVitamins,
                            onChanged: _updateNotifyVitamins,
                            value: _notifyVitamins,
                          ),
                          _ToggleTile(
                            title: l10n.settingsNotifyWater,
                            onChanged: _updateNotifyWater,
                            value: _notifyWater,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.lock_outline_rounded,
                      title: l10n.settingsAccountTitle,
                      subtitle: l10n.settingsAccountBody,
                      accent: ec.mint,
                      child: authSessionAsync.when(
                        data: (session) =>
                            _buildAccountSection(context, session, l10n),
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (error, _) => _InlineStateMessage(
                          text: '${l10n.errorGeneric}: $error',
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.local_hospital_outlined,
                      title: l10n.settingsLaborPrepTitle,
                      subtitle: l10n.settingsLaborPrepBody,
                      accent: ec.powderPink,
                      child: Column(
                        children: [
                          _ToggleTile(
                            title: l10n.settingsShowLaborButton,
                            subtitle: l10n.settingsShowLaborButtonBody,
                            onChanged: _updateLaborButtonVisibility,
                            value: _showLaborButton,
                          ),
                          const SizedBox(height: 14),
                          _InputBlock(
                            label: l10n.laborPartnerName,
                            child: _SettingsInputField(
                              controller: _partnerNameController,
                              hint: l10n.laborPartnerNameHint,
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InputBlock(
                            label: l10n.laborPartnerPhone,
                            child: _SettingsInputField(
                              controller: _partnerPhoneController,
                              hint: l10n.laborPartnerPhoneHint,
                              keyboardType: TextInputType.phone,
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InputBlock(
                            label: l10n.laborDoctorPhone,
                            child: _SettingsInputField(
                              controller: _doctorPhoneController,
                              hint: l10n.laborDoctorPhoneHint,
                              keyboardType: TextInputType.phone,
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InputBlock(
                            label: l10n.laborHospitalAddress,
                            child: _SettingsInputField(
                              controller: _hospitalAddressController,
                              hint: l10n.laborHospitalAddressHint,
                              maxLines: 2,
                              onSubmitted: () => _saveAllFields(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.description_outlined,
                      title: l10n.settingsDocsTitle,
                      subtitle: l10n.settingsDocsBody,
                      accent: ec.peach,
                      child: Column(
                        children: [
                          _ActionTile(
                            icon: Icons.picture_as_pdf_rounded,
                            title: l10n.settingsExportPdf,
                            subtitle: l10n.settingsDocsBody,
                            onTap: _isExporting ? null : _exportPdf,
                            trailing: _isExporting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : null,
                          ),
                          _DividerLine(),
                          _ActionTile(
                            icon: Icons.health_and_safety_outlined,
                            title: l10n.settingsDisclaimer,
                            subtitle: l10n.onboardingDisclaimerBody,
                            onTap: _showDisclaimer,
                          ),
                          _DividerLine(),
                          _ActionTile(
                            icon: Icons.privacy_tip_outlined,
                            title: l10n.settingsPrivacy,
                            subtitle: l10n.privacyUnavailable,
                            onTap: _showPrivacyUnavailable,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SettingsSection(
                      icon: Icons.delete_outline_rounded,
                      title: l10n.settingsDangerTitle,
                      subtitle: l10n.settingsDangerBody,
                      accent: Colors.redAccent,
                      child: _ActionTile(
                        icon: Icons.delete_forever_rounded,
                        title: l10n.settingsDeleteData,
                        subtitle: l10n.settingsDeleteDataConfirm,
                        onTap: _isDeletingData ? null : _wipeData,
                        trailing: _isDeletingData
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.redAccent,
                                ),
                              )
                            : null,
                        danger: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _SaveBar(
              helper: l10n.settingsSaveHelper,
              label: l10n.settingsSaveChanges,
              isSaving: _isSavingFields,
              onTap: () => _saveAllFields(showFeedback: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    AuthSession session,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final ec = theme.elpisColors;
    final muted = ec.textBrown.withValues(alpha: 0.7);

    if (session.isGuest) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.authGuestModeTitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: ec.textBrown,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.authGuestModeBody,
            style: theme.textTheme.bodyMedium?.copyWith(color: muted),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _isAuthActionInProgress
                  ? null
                  : () => _signInWithProvider(AuthIdentityProvider.google),
              icon: _isAuthActionInProgress
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.language_rounded),
              label: Text(l10n.authGoogleContinue),
            ),
          ),
          if (!kIsWeb &&
              (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS)) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isAuthActionInProgress
                    ? null
                    : () => _signInWithProvider(AuthIdentityProvider.apple),
                icon: const Icon(Icons.apple_rounded),
                label: Text(l10n.authAppleContinue),
              ),
            ),
          ],
        ],
      );
    }

    final displayName = session.displayName;
    final subtitle = session.email ??
        (displayName != null && displayName.isNotEmpty
            ? displayName
            : l10n.authSignedInSubtitle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.authSignedInTitle(_providerLabel(l10n, session.provider)),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: ec.textBrown,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(color: muted),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _isAuthActionInProgress ? null : _switchToGuest,
            child: _isAuthActionInProgress
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.authSwitchToGuestAction),
          ),
        ),
      ],
    );
  }

  String _providerLabel(AppLocalizations l10n, AuthIdentityProvider provider) {
    switch (provider) {
      case AuthIdentityProvider.google:
        return l10n.authGoogleProvider;
      case AuthIdentityProvider.apple:
        return l10n.authAppleProvider;
      case AuthIdentityProvider.guest:
        return l10n.authGuestProvider;
    }
  }
}

class _SettingsHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onClose;

  const _SettingsHeader({
    required this.title,
    required this.subtitle,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ec = theme.elpisColors;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 30,
                  color: ec.textBrown,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: ec.textBrown.withValues(alpha: 0.66),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        _CircleActionButton(
          icon: Icons.close_rounded,
          onTap: onClose,
        ),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            shape: BoxShape.circle,
            border: Border.all(
              color: ec.powderPink.withValues(alpha: 0.5),
            ),
          ),
          child: Icon(icon, size: 20, color: ec.textBrown),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String momName;
  final String babyName;
  final int currentWeek;
  final String dueDate;
  final String helper;

  const _OverviewCard({
    required this.title,
    required this.momName,
    required this.babyName,
    required this.currentWeek,
    required this.dueDate,
    required this.helper,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ec = theme.elpisColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.9),
            ec.lightBeige.withValues(alpha: 0.92),
          ],
        ),
        border: Border.all(
          color: ec.powderPink.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: ec.dustyRose.withValues(alpha: 0.1),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      ec.peach.withValues(alpha: 0.92),
                      ec.powderPink.withValues(alpha: 0.88),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: ec.textBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      helper,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: ec.textBrown.withValues(alpha: 0.62),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _MetricChip(
                  label: l10n.onboardingMomNameLabel,
                  value: momName,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricChip(
                  label: l10n.onboardingBabyNameLabel,
                  value: babyName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MetricChip(
                  label: l10n.currentWeekLabel,
                  value: '$currentWeek',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricChip(
                  label: l10n.onboardingEddLabel,
                  value: dueDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label;
  final String value;

  const _MetricChip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ec = theme.elpisColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: ec.textBrown.withValues(alpha: 0.52),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ec = theme.elpisColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: ec.powderPink.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: ec.textBrown,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: ec.textBrown.withValues(alpha: 0.66),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _MiniSectionLabel extends StatelessWidget {
  final String label;

  const _MiniSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: ec.textBrown.withValues(alpha: 0.48),
          ),
        ),
      ),
    );
  }
}

class _InputBlock extends StatelessWidget {
  final String label;
  final Widget child;

  const _InputBlock({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MiniSectionLabel(label: label),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _SettingsInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final Future<bool> Function()? onSubmitted;

  const _SettingsInputField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        onSubmitted?.call();
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: ec.textBrown.withValues(alpha: 0.34),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.72),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: ec.powderPink.withValues(alpha: 0.45),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: ec.powderPink.withValues(alpha: 0.45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: ec.dustyRose,
            width: 1.6,
          ),
        ),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String title;
  final String value;
  final String supporting;
  final VoidCallback onTap;

  const _DateCard({
    required this.title,
    required this.value,
    required this.supporting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: ec.powderPink.withValues(alpha: 0.42),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: ec.dustyRose.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: ec.dustyRose,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ec.textBrown.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ec.textBrown,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      supporting,
                      style: TextStyle(
                        fontSize: 12,
                        color: ec.textBrown.withValues(alpha: 0.64),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_rounded,
                size: 18,
                color: ec.textBrown.withValues(alpha: 0.48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentOption<T> {
  final T value;
  final String title;

  const _SegmentOption({
    required this.value,
    required this.title,
  });
}

class _SegmentRow<T> extends StatelessWidget {
  final T value;
  final List<_SegmentOption<T>> options;
  final ValueChanged<T> onChanged;

  const _SegmentRow({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = option.value == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ec.dustyRose.withValues(alpha: 0.16)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  option.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? ec.dustyRose
                        : ec.textBrown.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _VisualModeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisualModeCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? ec.dustyRose.withValues(alpha: 0.14)
                : Colors.white.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? ec.dustyRose
                  : ec.powderPink.withValues(alpha: 0.4),
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? ec.dustyRose
                    : ec.textBrown.withValues(alpha: 0.58),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? ec.dustyRose
                      : ec.textBrown.withValues(alpha: 0.64),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ec.textBrown,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: ec.textBrown.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          CupertinoSwitch(
            value: value,
            activeTrackColor: ec.dustyRose,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool danger;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final accent = danger ? Colors.redAccent : ec.dustyRose;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: danger ? Colors.redAccent : ec.textBrown,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: ec.textBrown.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: ec.textBrown.withValues(alpha: 0.4),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(
        height: 1,
        color: Theme.of(context).elpisColors.powderPink.withValues(alpha: 0.3),
      ),
    );
  }
}

class _InlineStateMessage extends StatelessWidget {
  final String text;

  const _InlineStateMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ec.peach.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ec.textBrown,
          height: 1.45,
        ),
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  final String helper;
  final String label;
  final bool isSaving;
  final VoidCallback onTap;

  const _SaveBar({
    required this.helper,
    required this.label,
    required this.isSaving,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: ec.powderPink.withValues(alpha: 0.42),
        ),
        boxShadow: [
          BoxShadow(
            color: ec.dustyRose.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            helper,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ec.textBrown.withValues(alpha: 0.58),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isSaving ? null : onTap,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: ec.dustyRose,
                disabledBackgroundColor: ec.dustyRose.withValues(alpha: 0.5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
