import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/holographic_background.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../subscription/presentation/paywall_sheet.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _babyNameController = TextEditingController();

  DateTime? _selectedLmpDate;
  DateTime? _selectedEddDate;
  bool _useEdd = false;
  String _selectedLanguage = 'ru';
  int _currentPage = 0;
  bool _isFinishing = false;

  static const int _totalPages = 4;

  @override
  void initState() {
    super.initState();
    _selectedLmpDate = DateTime.now().subtract(const Duration(days: 60));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _babyNameController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      FocusScope.of(context).unfocus();
      _goToPage(_currentPage + 1);
    } else {
      _finishOnboarding();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      FocusScope.of(context).unfocus();
      _goToPage(_currentPage - 1);
    }
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) return;
    setState(() => _isFinishing = true);
    FocusScope.of(context).unfocus();

    DateTime dueDate;
    if (_useEdd && _selectedEddDate != null) {
      dueDate = _selectedEddDate!;
    } else {
      final lmp =
          _selectedLmpDate ?? DateTime.now().subtract(const Duration(days: 60));
      dueDate = lmp.add(const Duration(days: 280));
    }

    try {
      await ref.read(pregnancyRepositoryProvider).updateSettings(
            name: _babyNameController.text.trim().isNotEmpty
                ? _babyNameController.text.trim()
                : null,
            momName: _nameController.text.trim().isNotEmpty
                ? _nameController.text.trim()
                : null,
            dueDate: dueDate,
            languageCode: _selectedLanguage,
          );

      // Запрашиваем разрешения на уведомления
      if (mounted) {
        await ref.read(notificationServiceProvider).requestPermissions();

        // ПОКАЗЫВАЕМ ПЭЙВОЛ В КОНЦЕ ОНБОРДИНГА
        if (mounted) {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const PaywallSheet(),
          );
        }
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
      setState(() => _isFinishing = false);
    }
  }

  bool get _canProceed {
    switch (_currentPage) {
      case 0:
        return true; // Язык — всегда можно продолжить
      case 1:
        return _nameController.text.trim().isNotEmpty;
      case 2:
        return _selectedLmpDate != null ||
            (_useEdd && _selectedEddDate != null);
      case 3:
        return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Scaffold(
      backgroundColor: ec.milky,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const HolographicBackground(),
          SafeArea(
            child: Column(
              children: [
                // ── Progress indicator ──────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Row(
                    children: List.generate(_totalPages, (i) {
                      final isActive = i <= _currentPage;
                      return Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          height: 4,
                          margin: EdgeInsets.only(
                              right: i < _totalPages - 1 ? 6 : 0),
                          decoration: BoxDecoration(
                            color: isActive
                                ? ec.dustyRose
                                : ec.powderPink.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // ── Back button ─────────────────────────────────
                if (_currentPage > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: IconButton(
                        onPressed: _prevPage,
                        icon: Icon(Icons.arrow_back_ios_new_rounded,
                            color: ec.textBrown, size: 20),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 48),

                // ── Pages ───────────────────────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      _LanguagePage(
                        selected: _selectedLanguage,
                        onSelect: (lang) =>
                            setState(() => _selectedLanguage = lang),
                      ),
                      _WelcomePage(
                        nameController: _nameController,
                        babyNameController: _babyNameController,
                        onNext: _nextPage,
                        languageCode: _selectedLanguage,
                      ),
                      _DatePage(
                        useEdd: _useEdd,
                        lmpDate: _selectedLmpDate,
                        eddDate: _selectedEddDate,
                        onToggleMode: (v) => setState(() => _useEdd = v),
                        onLmpChanged: (d) =>
                            setState(() => _selectedLmpDate = d),
                        onEddChanged: (d) =>
                            setState(() => _selectedEddDate = d),
                        languageCode: _selectedLanguage,
                      ),
                      _DisclaimerPage(languageCode: _selectedLanguage),
                    ],
                  ),
                ),

                // ── CTA Button ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    12,
                    24,
                    MediaQuery.viewInsetsOf(context).bottom + 32,
                  ),
                  child: AnimatedOpacity(
                    opacity: _canProceed ? 1.0 : 0.4,
                    duration: const Duration(milliseconds: 200),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            (_canProceed && !_isFinishing) ? _nextPage : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: ec.dustyRose,
                          disabledBackgroundColor: ec.dustyRose,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: _isFinishing
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Builder(builder: (ctx) {
                                final l10n = AppLocalizations.of(ctx);
                                return Text(
                                  _currentPage < _totalPages - 1
                                      ? l10n!.onboardingContinue
                                      : l10n!.onboardingBegin,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                );
                              }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Page 0: Язык ────────────────────────────────────────────────
class _LanguagePage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _LanguagePage({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌍', style: TextStyle(fontSize: 64))
              .animate()
              .scale(duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 24),
          Text(
            l10n.onboardingLanguagePrompt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
              height: 1.3,
            ),
          ).animate().fadeIn(delay: 200.ms).moveY(begin: 12, end: 0),
          const SizedBox(height: 40),
          _LangTile(
            flag: '🇷🇺',
            label: l10n.languageRussian,
            isSelected: selected == 'ru',
            onTap: () => onSelect('ru'),
          ),
          const SizedBox(height: 14),
          _LangTile(
            flag: '🇬🇧',
            label: l10n.languageEnglish,
            isSelected: selected == 'en',
            onTap: () => onSelect('en'),
          ),
        ],
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  final String flag;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _LangTile({
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected
              ? ec.dustyRose.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? ec.dustyRose
                : ec.powderPink.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? ec.dustyRose : ec.textBrown,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: ec.dustyRose, size: 22),
          ],
        ),
      ),
    );
  }
}

// ─── Page 1: Имя мамы и малыша ──────────────────────────────────
class _WelcomePage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController babyNameController;
  final VoidCallback onNext;
  final String languageCode;

  const _WelcomePage({
    required this.nameController,
    required this.babyNameController,
    required this.onNext,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(
            child: const Text('🌸', style: TextStyle(fontSize: 56))
                .animate()
                .scale(duration: 600.ms, curve: Curves.easeOutBack),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              l10n.onboardingStep1Title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: ec.textBrown,
              ),
            ).animate().fadeIn(delay: 150.ms).moveY(begin: 10, end: 0),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              l10n.onboardingStep1Sub,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: ec.textBrown.withValues(alpha: 0.65),
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 250.ms),
          ),
          const SizedBox(height: 36),
          Text(
            l10n.onboardingMomNameLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: ec.textBrown.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          _InputField(
            controller: nameController,
            hint: l10n.onboardingMomNameHint,
            onSubmitted: (_) => onNext(),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.onboardingBabyNameLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: ec.textBrown.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          _InputField(
            controller: babyNameController,
            hint: l10n.onboardingBabyNameHint,
            onSubmitted: (_) => onNext(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onSubmitted;

  const _InputField({
    required this.controller,
    required this.hint,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: ec.textBrown,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: ec.textBrown.withValues(alpha: 0.35), fontSize: 16),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.8),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: ec.powderPink, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
              color: ec.powderPink.withValues(alpha: 0.6), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: ec.dustyRose, width: 2),
        ),
      ),
    );
  }
}

// ─── Page 2: Дата ────────────────────────────────────────────────
class _DatePage extends StatelessWidget {
  final bool useEdd;
  final DateTime? lmpDate;
  final DateTime? eddDate;
  final ValueChanged<bool> onToggleMode;
  final ValueChanged<DateTime> onLmpChanged;
  final ValueChanged<DateTime> onEddChanged;
  final String languageCode;

  const _DatePage({
    required this.useEdd,
    required this.lmpDate,
    required this.eddDate,
    required this.onToggleMode,
    required this.onLmpChanged,
    required this.onEddChanged,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isRu = languageCode == 'ru';

    final activeDate = useEdd
        ? (eddDate ?? DateTime.now().add(const Duration(days: 200)))
        : (lmpDate ?? DateTime.now().subtract(const Duration(days: 60)));

    // Вычисляем ПДД для показа
    final calculatedDue =
        useEdd ? activeDate : activeDate.add(const Duration(days: 280));

    final formatter =
        DateFormat(isRu ? 'd MMMM yyyy' : 'MMMM d, yyyy', isRu ? 'ru' : 'en');

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text('📅', style: TextStyle(fontSize: 48))
              .animate()
              .scale(duration: 500.ms),
          const SizedBox(height: 16),
          Text(
            useEdd ? l10n.onboardingEddTitle : l10n.onboardingLmpTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
              height: 1.3,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 6),
          Text(
            useEdd ? l10n.onboardingEddSubtitle : l10n.onboardingLmpSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: ec.textBrown.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 16),

          // Переключатель режима
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ec.powderPink.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                _ModeTab(
                  label: l10n.onboardingByLmp,
                  isActive: !useEdd,
                  onTap: () => onToggleMode(false),
                ),
                _ModeTab(
                  label: l10n.onboardingByEdd,
                  isActive: useEdd,
                  onTap: () => onToggleMode(true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Календарь
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ec.powderPink.withValues(alpha: 0.4)),
            ),
            child: Theme(
              data: theme.copyWith(
                colorScheme: ColorScheme.light(primary: ec.dustyRose),
              ),
              child: CalendarDatePicker(
                key: ValueKey(useEdd),
                initialDate: activeDate,
                firstDate: useEdd
                    ? DateTime.now()
                    : DateTime.now().subtract(const Duration(days: 300)),
                lastDate: useEdd
                    ? DateTime.now().add(const Duration(days: 300))
                    : DateTime.now(),
                onDateChanged: useEdd ? onEddChanged : onLmpChanged,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Результат расчёта
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: ec.peach.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ec.dustyRose.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.child_friendly_rounded,
                    color: ec.dustyRose, size: 20),
                const SizedBox(width: 10),
                Text(
                  l10n.onboardingDueResult(formatter.format(calculatedDue)),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ec.textBrown,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _ModeTab(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? ec.dustyRose : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? Colors.white
                  : ec.textBrown.withValues(alpha: 0.55),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Page 3: Дисклеймер ──────────────────────────────────────────
class _DisclaimerPage extends StatelessWidget {
  final String languageCode;
  const _DisclaimerPage({required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('✨', style: TextStyle(fontSize: 60))
              .animate()
              .scale(duration: 600.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 24),
          Text(
            l10n.onboardingStep3Title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
            ),
          ).animate().fadeIn(delay: 100.ms).moveY(begin: 10, end: 0),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingStep3Sub,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: ec.textBrown.withValues(alpha: 0.65),
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: ec.lavender.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ec.lavender.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                Icon(Icons.health_and_safety_outlined,
                    color: ec.dustyRose, size: 28),
                const SizedBox(height: 10),
                Text(
                  l10n.onboardingDisclaimerTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ec.textBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onboardingDisclaimerBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: ec.textBrown.withValues(alpha: 0.65),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
    );
  }
}
