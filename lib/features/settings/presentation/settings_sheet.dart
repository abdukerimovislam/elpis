import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../reports/services/pdf_report_service.dart';

class SettingsSheet extends ConsumerStatefulWidget {
  final PregnancySettings currentSettings;

  const SettingsSheet({super.key, required this.currentSettings});

  @override
  ConsumerState<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends ConsumerState<SettingsSheet> {
  // Основные контроллеры
  late TextEditingController _nameController;
  late DateTime _pickerDate; // Дата последней менструации
  late String _languageCode;
  late String _visualModeKey;
  late String _themeKey;

  // Контроллеры для Labor Mode (Экстренные контакты)
  late TextEditingController _partnerNameController;
  late TextEditingController _partnerPhoneController;
  late TextEditingController _doctorPhoneController;
  late TextEditingController _hospitalAddressController;

  // 🔥 Локальное состояние свича "Показывать кнопку родов"
  late bool _showLaborButton;

  bool _isExporting = false;
  bool _isSavingFields = false;
  bool _isDeletingData = false;

  @override
  void initState() {
    super.initState();
    final s = widget.currentSettings;

    // Инициализация основных настроек
    _nameController = TextEditingController(text: s.babyName);
    _languageCode = s.languageCode;
    _visualModeKey = s.effectiveVisualModeKey;
    _themeKey = s.themeKey.isEmpty ? 'serenity' : s.themeKey;
    _pickerDate = s.estimatedDueDate.subtract(const Duration(days: 280));

    // Инициализация полей для родов
    _partnerNameController = TextEditingController(text: s.partnerName);
    _partnerPhoneController = TextEditingController(text: s.partnerPhone);
    _doctorPhoneController = TextEditingController(text: s.doctorPhone);
    _hospitalAddressController = TextEditingController(text: s.hospitalAddress);

    // Инициализация свича (если поле еще не создано в базе, считаем true)
    _showLaborButton = s.showLaborButton;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _partnerNameController.dispose();
    _partnerPhoneController.dispose();
    _doctorPhoneController.dispose();
    _hospitalAddressController.dispose();
    super.dispose();
  }

  DateTime get _finalDueDate {
    return _pickerDate.add(const Duration(days: 280));
  }

  void _showErrorSnack(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<bool> _safeRun(Future<void> Function() action) async {
    try {
      await action();
      return true;
    } catch (e, stack) {
      debugPrint("Settings Error: $e\n$stack");
      if (!mounted) {
        return false;
      }
      final l10n = AppLocalizations.of(context)!;
      _showErrorSnack("${l10n.errorGeneric}: $e");
      return false;
    }
  }

  // --- СОХРАНЕНИЕ ---

  Future<bool> _saveAllFields() async {
    if (_isSavingFields) {
      return false;
    }

    setState(() => _isSavingFields = true);
    final didSave = await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            name: _nameController.text.trim(),
            partnerName: _partnerNameController.text.trim(),
            partnerPhone: _partnerPhoneController.text.trim(),
            doctorPhone: _doctorPhoneController.text.trim(),
            hospitalAddress: _hospitalAddressController.text.trim(),
          );
    });
    if (mounted) {
      setState(() => _isSavingFields = false);
    }
    return didSave;
  }

  Future<void> _handleClose() async {
    final didSave = await _saveAllFields();
    if (!mounted || !didSave) {
      return;
    }
    Navigator.pop(context);
  }

  Future<void> _updateTheme(String key) async {
    setState(() => _themeKey = key);
    await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).setTheme(key);
    });
  }

  Future<void> _updateLanguage(String code) async {
    setState(() => _languageCode = code);
    await _safeRun(() async {
      await ref
          .read(pregnancyRepositoryProvider)
          .updateSettings(languageCode: code);
    });
  }

  Future<void> _updateMode(String visualModeKey) async {
    setState(() => _visualModeKey = visualModeKey);
    await _safeRun(() async {
      await ref.read(pregnancyRepositoryProvider).setVisualMode(visualModeKey);
    });
  }

  // 🔥 Метод для сохранения настройки кнопки
  Future<void> _updateLaborButtonVisibility(bool value) async {
    setState(() => _showLaborButton = value);
    await _safeRun(() async {
      await ref
          .read(pregnancyRepositoryProvider)
          .updateSettings(showLaborButton: value);
    });
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
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _pickerDate = picked);
      await _safeRun(() async {
        await ref.read(pregnancyRepositoryProvider).saveDueDate(_finalDueDate);
      });
    }
  }

  // --- ЭКСПОРТ И УДАЛЕНИЕ ---

  Future<void> _exportPdf() async {
    if (_isExporting) return;
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
            weights.map((w) => WeightEntry(w.date, w.weightKg ?? 0)).toList(),
        kickHistory: kickHistory
            .map((k) => KickSession(k.date, 0, k.totalKicks))
            .toList(),
        recentSymptoms: recentSymptoms,
      );

      final pdfBytes =
          await PdfReportService().generateReport(reportData, locale, l10n);
      await Printing.sharePdf(bytes: pdfBytes, filename: 'Bloom_Report.pdf');
    } catch (e) {
      debugPrint("PDF Error: $e");
      _showErrorSnack(l10n.errorGeneric);
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  void _wipeData() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsDeleteData),
        content: Text(l10n.settingsDeleteDataConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonCancel)),
          TextButton(
              onPressed: () async {
                if (_isDeletingData) {
                  return;
                }

                final dialogNavigator = Navigator.of(context);
                final sheetNavigator = Navigator.of(this.context);
                if (mounted) {
                  setState(() => _isDeletingData = true);
                }
                try {
                  await ref.read(pregnancyRepositoryProvider).clearAllData();
                  if (dialogNavigator.mounted) {
                    dialogNavigator.pop();
                  }
                  if (mounted) {
                    sheetNavigator.pop(); // Закрываем Sheet
                  }
                } catch (e) {
                  debugPrint("Wipe Error: $e");
                  if (dialogNavigator.mounted) {
                    dialogNavigator.pop();
                  }
                  _showErrorSnack(l10n.errorDeleteData);
                } finally {
                  if (mounted) {
                    setState(() => _isDeletingData = false);
                  }
                }
              },
              child: Text(l10n.commonDelete,
                  style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  void _showPrivacyUnavailable() {
    final l10n = AppLocalizations.of(context)!;
    final body = Localizations.localeOf(context).languageCode == 'ru'
        ? 'Политика конфиденциальности пока не добавлена в приложение.'
        : 'Privacy policy has not been added to the app yet.';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsPrivacy),
        content: Text(
          body,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonUnderstood),
          ),
        ],
      ),
    );
  }

  void _showDisclaimer() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.disclaimerTitle),
        content: SingleChildScrollView(child: Text(l10n.disclaimerBody)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonUnderstood))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final bgLight = theme.scaffoldBackgroundColor;
    final textMuted = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final cardColor = theme.cardColor;

    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        await _saveAllFields();
      },
      child: Container(
        height: MediaQuery.of(context).size.height *
            0.92, // Чуть выше для клавиатуры
        padding: EdgeInsets.only(
          top: 24, left: 24, right: 24,
          // Важно для клавиатуры:
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: BoxDecoration(
          color: bgLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: textMuted.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.settingsTitle,
                    style:
                        theme.textTheme.displayLarge?.copyWith(fontSize: 24)),
                IconButton(
                  onPressed: _isSavingFields ? null : _handleClose,
                  icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: cardColor, shape: BoxShape.circle),
                      child: _isSavingFields
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: textMuted,
                              ),
                            )
                          : Icon(Icons.close, size: 20, color: textMuted)),
                )
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. NAME
                    _buildSectionTitle(context, l10n.settingsNameLabel),
                    _buildTextField(
                        context, _nameController, l10n.settingsNameHint),

                    const SizedBox(height: 24),

                    // 2. EMERGENCY PREP (Сюда добавляем свич)
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                            l10n.laborEmergencyPrepTitle, // "EMERGENCY PREP"
                            style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: primaryColor)),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        initiallyExpanded: false,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: cardColor.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color:
                                        primaryColor.withValues(alpha: 0.1))),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔥 НОВЫЙ СВИЧ: ВКЛ/ВЫКЛ КНОПКИ РОДОВ 🔥
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        l10n.laborTriggerButton,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      value: _showLaborButton,
                                      activeTrackColor: primaryColor,
                                      onChanged: _updateLaborButtonVisibility,
                                    ),
                                  ],
                                ),
                                const Divider(height: 24),

                                Text(
                                    l10n
                                        .laborEmergencyPrepSubtitle, // "Fill this now..."
                                    style: TextStyle(
                                        fontSize: 12, color: textMuted)),
                                const SizedBox(height: 16),

                                _buildSmallLabel(
                                    l10n.laborPartnerName), // "Partner's Name"
                                _buildTextField(context, _partnerNameController,
                                    "e.g. Alex",
                                    isSmall: true),
                                const SizedBox(height: 12),

                                _buildSmallLabel(l10n
                                    .laborPartnerPhone), // "Partner's Phone"
                                _buildTextField(context,
                                    _partnerPhoneController, "+1 234 ...",
                                    isPhone: true, isSmall: true),
                                const SizedBox(height: 12),

                                _buildSmallLabel(
                                    l10n.laborDoctorPhone), // "Doctor's Phone"
                                _buildTextField(context, _doctorPhoneController,
                                    "Emergency contact",
                                    isPhone: true, isSmall: true),
                                const SizedBox(height: 12),

                                _buildSmallLabel(l10n
                                    .laborHospitalAddress), // "Hospital Address"
                                _buildTextField(
                                    context,
                                    _hospitalAddressController,
                                    "Street, Building...",
                                    isSmall: true),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 3. LANGUAGE
                    _buildSectionTitle(context, l10n.languageLabel),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<String>(
                        groupValue: _languageCode,
                        backgroundColor: cardColor,
                        thumbColor: theme.scaffoldBackgroundColor,
                        padding: const EdgeInsets.all(4),
                        children: {
                          'en': Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text("English",
                                  style: theme.textTheme.bodyMedium)),
                          'ru': Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text("Русский",
                                  style: theme.textTheme.bodyMedium)),
                        },
                        onValueChanged: (value) {
                          if (value != null) _updateLanguage(value);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 4. THEME
                    _buildSectionTitle(context, l10n.settingsThemeTitle),
                    Row(
                      children: [
                        _buildThemeOption('serenity', const Color(0xFF7D93B2),
                            l10n.themeSerenity),
                        const SizedBox(width: 16),
                        _buildThemeOption(
                            'sage', const Color(0xFF9CAF88), l10n.themeNature),
                        const SizedBox(width: 16),
                        _buildThemeOption(
                            'peach', const Color(0xFFE29587), l10n.themeWarmth),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 5. VISUAL MODE
                    _buildSectionTitle(context, l10n.settingsVisualMode),
                    Row(
                      children: [
                        Expanded(
                            child: _buildModeCard(
                                context,
                                PregnancySettings.visualModeFruit,
                                l10n.visualModeFruit,
                                Icons.eco)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildModeCard(
                                context,
                                PregnancySettings.visualModeRealistic,
                                l10n.visualModeRealistic,
                                Icons.lens_blur)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildModeCard(
                                context,
                                PregnancySettings.visualModeGrowth,
                                Localizations.localeOf(context).languageCode ==
                                        'ru'
                                    ? 'Развитие'
                                    : 'Growth',
                                Icons.child_friendly_rounded)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 6. DATE PICKER (NEW DIALOG STYLE)
                    _buildSectionTitle(
                        context, l10n.onboardingLmpLabel.toUpperCase()),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: primaryColor.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, color: primaryColor),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.yMMMMd(
                                            Localizations.localeOf(context)
                                                .toString())
                                        .format(_pickerDate),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    l10n.onboardingCalculatedDate(
                                        DateFormat.yMMMd(
                                                Localizations.localeOf(context)
                                                    .toString())
                                            .format(_finalDueDate)),
                                    style: TextStyle(
                                        fontSize: 12, color: textMuted),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.edit, size: 16, color: textMuted),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // EXPORT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isExporting ? null : _exportPdf,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: primaryColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        icon: _isExporting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : Icon(Icons.picture_as_pdf, color: primaryColor),
                        label: Text(
                          _isExporting
                              ? l10n.exportingPdf
                              : l10n.settingsExportPdf,
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // LEGAL & INFO SECTION
                    Center(
                        child: Column(
                      children: [
                        Text(l10n.settingsLegalTitle,
                            style: theme.textTheme.labelSmall),
                        const SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          children: [
                            TextButton(
                              onPressed: _showPrivacyUnavailable,
                              child: Text(l10n.settingsPrivacy,
                                  style: TextStyle(
                                      color: textMuted, fontSize: 12)),
                            ),
                            TextButton(
                              onPressed: _showDisclaimer,
                              child: Text(l10n.settingsDisclaimer,
                                  style: TextStyle(
                                      color: textMuted, fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    )),

                    const SizedBox(height: 16),

                    // DELETE DATA
                    Center(
                      child: TextButton(
                        onPressed: _wipeData,
                        child: Text(l10n.settingsDeleteData,
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.labelSmall),
    );
  }

  Widget _buildSmallLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildTextField(
      BuildContext context, TextEditingController controller, String hint,
      {bool isPhone = false, bool isSmall = false}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: isSmall ? theme.scaffoldBackgroundColor : theme.cardColor,
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        style:
            theme.textTheme.bodyMedium?.copyWith(fontSize: isSmall ? 15 : 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle:
              TextStyle(fontSize: isSmall ? 14 : 16, color: Colors.black26),
          contentPadding:
              isSmall ? const EdgeInsets.symmetric(vertical: 10) : null,
        ),
        onEditingComplete: () {
          FocusScope.of(context).unfocus(); // При Enter сохраняем
          _saveAllFields();
        },
      ),
    );
  }

  Widget _buildModeCard(
      BuildContext context, String visualModeKey, String label, IconData icon) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isActive = _visualModeKey == visualModeKey;

    return GestureDetector(
      onTap: () => _updateMode(visualModeKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              isActive ? primaryColor.withValues(alpha: 0.15) : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isActive ? primaryColor : Colors.transparent, width: 1.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: isActive ? primaryColor : Colors.grey),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    color: isActive ? primaryColor : Colors.grey,
                    fontWeight:
                        isActive ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String key, Color color, String label) {
    final isSelected = _themeKey == key;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _updateTheme(key),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: theme.primaryColor, width: 3)
                    : null,
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 1)
                ]),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? theme.primaryColor : Colors.grey,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
