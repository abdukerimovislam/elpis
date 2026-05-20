import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/notifications/notification_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const int _totalPages = 4;

  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _babyNameController = TextEditingController();

  DateTime? _selectedLmpDate;
  DateTime? _selectedEddDate;
  bool _useEdd = false;
  String _selectedLanguage = 'ru';
  int _currentPage = 0;
  bool _isFinishing = false;

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

  bool get _canProceed {
    switch (_currentPage) {
      case 0:
        return true;
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

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 520),
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

    final lmp =
        _selectedLmpDate ?? DateTime.now().subtract(const Duration(days: 60));
    final dueDate = _useEdd && _selectedEddDate != null
        ? _selectedEddDate!
        : lmp.add(const Duration(days: 280));

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

      if (mounted) {
        await ref.read(notificationServiceProvider).requestPermissions();
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGenericRetry)),
      );
      setState(() => _isFinishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: Locale(_selectedLanguage),
      child: Builder(
        builder: (localizedContext) {
          final theme = Theme.of(localizedContext);
          final ec = theme.elpisColors;
          final l10n = AppLocalizations.of(localizedContext)!;

          return Scaffold(
            backgroundColor: ec.milky,
            body: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ec.milky,
                    Colors.white,
                    ec.lightBeige.withValues(alpha: 0.75),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  const _OnboardingBackdrop(),
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 10),
                          child: Row(
                            children: [
                              if (_currentPage > 0)
                                _TopCircleButton(
                                  icon: Icons.arrow_back_ios_new_rounded,
                                  onTap: _prevPage,
                                )
                              else
                                const SizedBox(width: 44),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _ProgressHeader(
                                  currentPage: _currentPage,
                                  totalPages: _totalPages,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.72),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ec.powderPink.withValues(alpha: 0.45),
                                  ),
                                ),
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: 20,
                                  color: ec.dustyRose,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                              _CompletionPage(
                                momName: _nameController.text.trim(),
                                babyName: _babyNameController.text.trim(),
                                dueDate: _useEdd && _selectedEddDate != null
                                    ? _selectedEddDate!
                                    : (_selectedLmpDate ??
                                            DateTime.now()
                                                .subtract(const Duration(days: 60)))
                                        .add(const Duration(days: 280)),
                                languageCode: _selectedLanguage,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            24,
                            10,
                            24,
                            MediaQuery.viewInsetsOf(localizedContext).bottom + 24,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.78),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: ec.powderPink.withValues(alpha: 0.38),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ec.dustyRose.withValues(alpha: 0.08),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_currentPage == 0)
                                  _FooterHint(text: l10n.onboardingLanguageBody)
                                else if (_currentPage == 1)
                                  _FooterHint(text: l10n.onboardingProfileBody)
                                else if (_currentPage == 2)
                                  _FooterHint(text: l10n.onboardingDateBody)
                                else
                                  _FooterHint(text: l10n.onboardingReadyBody),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (_canProceed && !_isFinishing)
                                        ? _nextPage
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                      ),
                                      backgroundColor: ec.dustyRose,
                                      disabledBackgroundColor:
                                          ec.dustyRose.withValues(alpha: 0.45),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: _isFinishing
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            _currentPage < _totalPages - 1
                                                ? l10n.onboardingContinue
                                                : l10n.onboardingBegin,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OnboardingBackdrop extends StatelessWidget {
  const _OnboardingBackdrop();

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Stack(
      children: [
        Positioned(
          top: -80,
          left: -50,
          child: _BlurOrb(
            size: 220,
            color: ec.powderPink.withValues(alpha: 0.28),
          ),
        ),
        Positioned(
          top: 120,
          right: -70,
          child: _BlurOrb(
            size: 200,
            color: ec.mint.withValues(alpha: 0.24),
          ),
        ),
        Positioned(
          bottom: -40,
          left: 20,
          child: _BlurOrb(
            size: 240,
            color: ec.peach.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }
}

class _BlurOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _ProgressHeader({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Row(
      children: List.generate(totalPages, (index) {
        final isActive = index <= currentPage;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            height: 6,
            margin: EdgeInsets.only(right: index == totalPages - 1 ? 0 : 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: isActive
                    ? [ec.dustyRose, ec.peach]
                    : [
                        ec.powderPink.withValues(alpha: 0.35),
                        ec.lightBeige.withValues(alpha: 0.3),
                      ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TopCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopCircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            shape: BoxShape.circle,
            border: Border.all(
              color: ec.powderPink.withValues(alpha: 0.45),
            ),
          ),
          child: Icon(icon, size: 18, color: ec.textBrown),
        ),
      ),
    );
  }
}

class _FooterHint extends StatelessWidget {
  final String text;

  const _FooterHint({required this.text});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: ec.textBrown.withValues(alpha: 0.58),
        height: 1.4,
      ),
    );
  }
}

class _OnboardingSurface extends StatelessWidget {
  final Widget child;

  const _OnboardingSurface({required this.child});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: ec.powderPink.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: ec.dustyRose.withValues(alpha: 0.08),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _LanguagePage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const _LanguagePage({
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: _OnboardingSurface(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _HeroMedallion(
            icon: Icons.language_rounded,
            accent: ec.mint,
          ),
          const SizedBox(height: 22),
          Text(
            l10n.onboardingLanguagePrompt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
              height: 1.2,
            ),
          ).animate().fadeIn().moveY(begin: 12, end: 0),
          const SizedBox(height: 10),
          Text(
            l10n.onboardingLanguageBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: ec.textBrown.withValues(alpha: 0.64),
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 28),
          _ChoiceTile(
            emoji: '🇷🇺',
            title: l10n.languageRussian,
            subtitle: 'Русский',
            isSelected: selected == 'ru',
            onTap: () => onSelect('ru'),
          ),
          const SizedBox(height: 14),
          _ChoiceTile(
            emoji: '🇬🇧',
            title: l10n.languageEnglish,
            subtitle: 'English',
            isSelected: selected == 'en',
            onTap: () => onSelect('en'),
          ),
        ],
      ),
    )
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController babyNameController;

  const _WelcomePage({
    required this.nameController,
    required this.babyNameController,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: _OnboardingSurface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _HeroMedallion(
                icon: Icons.favorite_rounded,
                accent: ec.peach,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.onboardingStep1Title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: ec.textBrown,
              ),
            ).animate().fadeIn().moveY(begin: 12, end: 0),
            const SizedBox(height: 10),
            Text(
              l10n.onboardingProfileBody,
              style: TextStyle(
                fontSize: 15,
                color: ec.textBrown.withValues(alpha: 0.64),
                height: 1.55,
              ),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 28),
            _InputLabel(label: l10n.onboardingMomNameLabel),
            const SizedBox(height: 8),
            _InputField(
              controller: nameController,
              hint: l10n.onboardingMomNameHint,
            ),
            const SizedBox(height: 20),
            _InputLabel(label: l10n.onboardingBabyNameLabel),
            const SizedBox(height: 8),
            _InputField(
              controller: babyNameController,
              hint: l10n.onboardingBabyNameHint,
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ec.lightBeige.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: ec.dustyRose,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.onboardingReadyBody,
                      style: TextStyle(
                        fontSize: 13,
                        color: ec.textBrown.withValues(alpha: 0.66),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    final l10n = AppLocalizations.of(context)!;
    final isRu = languageCode == 'ru';

    final activeDate = useEdd
        ? (eddDate ?? DateTime.now().add(const Duration(days: 200)))
        : (lmpDate ?? DateTime.now().subtract(const Duration(days: 60)));
    final calculatedDue =
        useEdd ? activeDate : activeDate.add(const Duration(days: 280));
    final formatter =
        DateFormat(isRu ? 'd MMMM yyyy' : 'MMMM d, yyyy', isRu ? 'ru' : 'en');

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: _OnboardingSurface(
        child: Column(
          children: [
            _HeroMedallion(
              icon: Icons.calendar_today_rounded,
              accent: ec.lavender,
            ),
            const SizedBox(height: 22),
            Text(
              l10n.onboardingStep2Title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: ec.textBrown,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.onboardingDateBody,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: ec.textBrown.withValues(alpha: 0.64),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _ModeChoiceCard(
                    label: l10n.onboardingByLmp,
                    isActive: !useEdd,
                    onTap: () => onToggleMode(false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ModeChoiceCard(
                    label: l10n.onboardingByEdd,
                    isActive: useEdd,
                    onTap: () => onToggleMode(true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: ec.powderPink.withValues(alpha: 0.38),
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
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
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ec.peach.withValues(alpha: 0.48),
                    ec.lightBeige.withValues(alpha: 0.62),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: ec.dustyRose.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    formatter.format(activeDate),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ec.textBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.onboardingCalculatedDate(
                      DateFormat.yMMMd(
                        Localizations.localeOf(context).toString(),
                      ).format(calculatedDue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: ec.textBrown.withValues(alpha: 0.68),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionPage extends StatelessWidget {
  final String momName;
  final String babyName;
  final DateTime dueDate;
  final String languageCode;

  const _CompletionPage({
    required this.momName,
    required this.babyName,
    required this.dueDate,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    final l10n = AppLocalizations.of(context)!;
    final formatter = DateFormat.yMMMd(languageCode);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: _OnboardingSurface(
        child: Column(
          children: [
          _HeroMedallion(
            icon: Icons.nights_stay_rounded,
            accent: ec.powderPink,
          ),
          const SizedBox(height: 22),
          Text(
            l10n.onboardingStep3Title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ec.textBrown,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.onboardingReadyBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: ec.textBrown.withValues(alpha: 0.64),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _InfoStrip(
            label: l10n.onboardingMomNameLabel,
            value: momName.isEmpty ? '-' : momName,
          ),
          const SizedBox(height: 10),
          _InfoStrip(
            label: l10n.onboardingBabyNameLabel,
            value: babyName.isEmpty ? '-' : babyName,
          ),
          const SizedBox(height: 10),
          _InfoStrip(
            label: l10n.onboardingEddLabel,
            value: formatter.format(dueDate),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: ec.mint.withValues(alpha: 0.34),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: ec.mint.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.health_and_safety_outlined,
                  color: ec.dustyRose,
                  size: 28,
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.onboardingDisclaimerTitle,
                  textAlign: TextAlign.center,
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
                    color: ec.textBrown.withValues(alpha: 0.66),
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _HeroMedallion extends StatelessWidget {
  final IconData icon;
  final Color accent;

  const _HeroMedallion({
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            accent.withValues(alpha: 0.92),
            accent.withValues(alpha: 0.34),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.18),
            blurRadius: 28,
            spreadRadius: 6,
          ),
        ],
      ),
      child: Icon(icon, size: 42, color: Colors.white),
    ).animate().scale(duration: 560.ms, curve: Curves.easeOutBack);
  }
}

class _ChoiceTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: isSelected
                ? ec.dustyRose.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected
                  ? ec.dustyRose
                  : ec.powderPink.withValues(alpha: 0.5),
              width: isSelected ? 1.8 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: ec.textBrown,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: ec.textBrown.withValues(alpha: 0.56),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: isSelected ? 1 : 0,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: ec.dustyRose,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  final String label;

  const _InputLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: ec.textBrown.withValues(alpha: 0.52),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputField({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: ec.textBrown,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: ec.textBrown.withValues(alpha: 0.34),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.85),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ec.powderPink.withValues(alpha: 0.55),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ec.powderPink.withValues(alpha: 0.55),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ec.dustyRose, width: 1.8),
        ),
      ),
    );
  }
}

class _ModeChoiceCard extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ModeChoiceCard({
    required this.label,
    required this.isActive,
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
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: isActive
              ? ec.dustyRose.withValues(alpha: 0.16)
              : Colors.white.withValues(alpha: 0.64),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive
                ? ec.dustyRose
                : ec.powderPink.withValues(alpha: 0.42),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isActive ? ec.dustyRose : ec.textBrown,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _InfoStrip extends StatelessWidget {
  final String label;
  final String value;

  const _InfoStrip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: ec.powderPink.withValues(alpha: 0.34),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: ec.textBrown.withValues(alpha: 0.52),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ec.textBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
