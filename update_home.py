import sys

new_content = """import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

import '../../../core/ui/glass_text_field.dart';
import '../../../core/ui/glass_card.dart';

import '../../health/presentation/symptom_sheet.dart';
import '../../health/presentation/weight_sheet.dart';
import '../../health/presentation/kick_counter_sheet.dart';
import '../../health/presentation/water_sheet.dart';
import '../../health/presentation/contraction_timer_sheet.dart';
import '../../health/presentation/checklist_sheet.dart';
import '../../health/presentation/kegel_sheet.dart';
import '../../health/presentation/doctor_visits_sheet.dart';
import '../../family/presentation/bump_gallery_sheet.dart';

import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/data/insight_repository.dart';
import '../../pregnancy/domain/insight.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../pregnancy/presentation/widgets/fetal_growth_section.dart';
import '../../settings/presentation/settings_sheet.dart';
import '../../pregnancy/presentation/diary_sheet.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

import 'widgets/living_sphere_display.dart';
import 'widgets/orbit_navigation_ui.dart';
import 'widgets/week_detail_insight_card.dart';

import '../../labor/presentation/labor_trigger_button.dart';
import '../../labor/presentation/labor_confirm_sheet.dart';
import 'widgets/week_picker_sheet.dart';

final orbitSettingsProvider = StreamProvider.autoDispose<PregnancySettings?>((ref) {
  return ref.watch(pregnancyRepositoryProvider).watchSettings();
});

class LivingOrbitScreen extends ConsumerStatefulWidget {
  const LivingOrbitScreen({super.key});

  @override
  ConsumerState<LivingOrbitScreen> createState() => _LivingOrbitScreenState();
}

class _LivingOrbitScreenState extends ConsumerState<LivingOrbitScreen> {
  final TextEditingController _letterController = TextEditingController();

  int? _overrideWeek;
  int? _lastLoadedLetterWeek;
  int _weekTransitionDirection = 1;

  String _visualModeKey = PregnancySettings.visualModeFruit;
  bool _isSavingLetter = false;
  bool _isTogglingVisualMode = false;
  String _loadedLetterText = "";

  @override
  void dispose() {
    _letterController.dispose();
    super.dispose();
  }

  void _setDisplayedWeek(int week, int realWeek) {
    final safeWeek = week.clamp(1, 42);
    final currentDisplay = _overrideWeek ?? realWeek;
    setState(() {
      _weekTransitionDirection = safeWeek >= currentDisplay ? 1 : -1;
      _overrideWeek = safeWeek == realWeek ? null : safeWeek;
    });
    _loadLetter(safeWeek);
  }

  void _handleSphereSwipe(int displayWeek, int realWeek, DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 250) {
      return;
    }

    HapticFeedback.selectionClick();
    if (velocity < 0) {
      _setDisplayedWeek(displayWeek + 1, realWeek);
    } else {
      _setDisplayedWeek(displayWeek - 1, realWeek);
    }
  }

  void _showErrorSnack(String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _loadLetter(int week) async {
    if (_lastLoadedLetterWeek == week) return;
    _lastLoadedLetterWeek = week;

    try {
      final snapshot = await ref.read(pregnancyRepositoryProvider).getOrCreateSnapshot(week);
      if (!mounted || _lastLoadedLetterWeek != week) return;

      final letter = snapshot.letterToBaby ?? "";
      setState(() {
        _loadedLetterText = letter;
        _letterController.text = letter;
      });
    } catch (_) {
      if (!mounted || _lastLoadedLetterWeek != week) return;
      _showErrorSnack(
        AppLocalizations.of(context)?.errorGeneric ?? "Something went wrong. Please try again.",
      );
    }
  }

  Future<void> _saveLetter(int week) async {
    final text = _letterController.text;
    if (_isSavingLetter || text == _loadedLetterText) return;

    setState(() => _isSavingLetter = true);

    try {
      await ref.read(pregnancyRepositoryProvider).saveLetter(week, text);
      _loadedLetterText = text;
    } catch (_) {
      if (mounted) {
        _showErrorSnack(
          AppLocalizations.of(context)?.errorGeneric ?? "Something went wrong. Please try again.",
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSavingLetter = false);
      }
    }
  }

  Future<void> _toggleVisualMode() async {
    if (_isTogglingVisualMode) return;

    HapticFeedback.selectionClick();
    final repo = ref.read(pregnancyRepositoryProvider);
    const modeOrder = [
      PregnancySettings.visualModeFruit,
      PregnancySettings.visualModeRealistic,
      PregnancySettings.visualModeGrowth,
    ];
    final currentIndex = modeOrder.indexOf(_visualModeKey);
    final nextMode = modeOrder[(currentIndex == -1 ? 0 : currentIndex + 1) % modeOrder.length];

    setState(() {
      _visualModeKey = nextMode;
      _isTogglingVisualMode = true;
    });

    try {
      await repo.setVisualMode(nextMode);
    } catch (_) {
      if (mounted) {
        setState(() {
          _visualModeKey = currentIndex == -1 ? PregnancySettings.visualModeFruit : modeOrder[currentIndex];
        });
        _showErrorSnack(
          AppLocalizations.of(context)?.errorGeneric ?? "Something went wrong. Please try again.",
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTogglingVisualMode = false);
      }
    }
  }

  void _openSettings(PregnancySettings settings) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (c) => SettingsSheet(currentSettings: settings));
  }

  void _openWeekPicker(int realWeek) async {
    HapticFeedback.selectionClick();
    final selectedWeek = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const WeekPickerSheet(),
    );

    if (selectedWeek != null && mounted) {
      _setDisplayedWeek(selectedWeek, realWeek);
    }
  }

  void _openSheet(Widget sheet) {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => sheet,
    );
  }

  void _openFullScreen(Widget sheet) {
    HapticFeedback.selectionClick();
    Navigator.push(context, MaterialPageRoute(builder: (_) => sheet));
  }

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'water_drop': return Icons.water_drop_outlined;
      case 'local_hospital': return Icons.local_hospital_outlined;
      case 'favorite': return Icons.favorite_border;
      case 'psychology': return Icons.psychology_outlined;
      case 'accessibility_new': return Icons.accessibility_new_outlined;
      case 'spa': return Icons.spa_outlined;
      case 'child_care': return Icons.child_care;
      default: return Icons.info_outline;
    }
  }

  String _trimesterLabel(int week, String languageCode) {
    final isRu = languageCode == 'ru';
    if (week <= 13) return isRu ? 'I триместр' : 'Trimester I';
    if (week <= 26) return isRu ? 'II триместр' : 'Trimester II';
    return isRu ? 'III триместр' : 'Trimester III';
  }

  Widget _buildBentoTools(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _BentoCard(
                  icon: Icons.timer_outlined,
                  title: l10n.toolContractions,
                  subtitle: l10n.toolContractionsSub,
                  color: const Color(0xFFE8EAF6),
                  onTap: () => _openFullScreen(const ContractionTimerSheet()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  icon: Icons.touch_app_outlined,
                  title: l10n.toolKicks,
                  subtitle: l10n.toolKicksSub,
                  color: const Color(0xFFFFF3E0),
                  onTap: () => _openFullScreen(const KickCounterSheet()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _BentoCard(
                  icon: Icons.scale_outlined,
                  title: l10n.toolWeight,
                  color: const Color(0xFFE1F5FE),
                  isSmall: true,
                  onTap: () => _openSheet(const WeightSheet()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  icon: Icons.water_drop_outlined,
                  title: l10n.toolWater,
                  color: const Color(0xFFE0F7FA),
                  isSmall: true,
                  onTap: () => _openSheet(const WaterSheet()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  icon: Icons.fitness_center_outlined,
                  title: l10n.toolKegel,
                  color: const Color(0xFFF3E5F5),
                  isSmall: true,
                  onTap: () => _openSheet(const KegelSheet()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _BentoCard(
                  icon: Icons.shopping_bag_outlined,
                  title: l10n.toolBag,
                  color: const Color(0xFFE0F2F1),
                  isSmall: true,
                  onTap: () => _openSheet(const ChecklistSheet()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  icon: Icons.favorite_border,
                  title: l10n.toolSymptoms,
                  color: const Color(0xFFFFE4E1),
                  isSmall: true,
                  onTap: () => _openSheet(const SymptomSheet()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  icon: Icons.calendar_month_outlined,
                  title: l10n.toolVisits,
                  color: const Color(0xFFFFFDE7),
                  isSmall: true,
                  onTap: () => _openSheet(const DoctorVisitsSheet()),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildLettersSection(BuildContext context, AppLocalizations l10n, int week, String? babyName) {
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              (babyName != null && babyName.isNotEmpty)
                  ? l10n.connectionTitleNamed(babyName)
                  : l10n.connectionTitle,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 22, color: mutedColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GlassTextField(
                controller: _letterController,
                hintText: l10n.connectionPlaceholder,
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  await _saveLetter(week);
                }),
            const SizedBox(height: 16),
            TextButton.icon(
                onPressed: () {
                  _openSheet(const DiarySheet());
                },
                icon: Icon(Icons.history_edu, size: 16, color: mutedColor),
                label: Text(l10n.connectionOpenDiary, style: theme.textTheme.labelSmall?.copyWith(color: mutedColor))),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final primaryColor = theme.primaryColor;
    final locale = Localizations.localeOf(context).languageCode;

    if (l10n == null) return Scaffold(backgroundColor: theme.scaffoldBackgroundColor);

    ref.listen<AsyncValue<PregnancySettings?>>(
      orbitSettingsProvider,
      (previous, next) {
        final prevDue = previous?.value?.estimatedDueDate;
        final nextDue = next.value?.estimatedDueDate;
        final currentWeek = next.value?.currentWeek;

        if (prevDue != null && nextDue != null && prevDue != nextDue) {
          setState(() {
            _overrideWeek = null;
            _letterController.clear();
            _lastLoadedLetterWeek = null;
            _loadedLetterText = "";
          });
        }

        if (currentWeek != null && _lastLoadedLetterWeek == null) {
          _loadLetter(_overrideWeek ?? currentWeek);
        }
      },
    );

    final settingsAsync = ref.watch(orbitSettingsProvider);

    if (settingsAsync.isLoading && !settingsAsync.hasValue) {
      return Scaffold(backgroundColor: theme.scaffoldBackgroundColor);
    }

    final settings = settingsAsync.valueOrNull;
    if (settings == null) return const OnboardingScreen();

    final settingsVisualMode = settings.effectiveVisualModeKey;
    if (!_isTogglingVisualMode && _visualModeKey != settingsVisualMode) {
      _visualModeKey = settingsVisualMode;
    }

    final realWeek = settings.currentWeek;
    final displayWeek = _overrideWeek ?? realWeek;
    final isBrowsingHistory = displayWeek != realWeek;
    
    // Insights Data
    final objectData = ref.read(insightRepositoryProvider).getObjectData(displayWeek, locale, _visualModeKey);
    final insights = ref.read(insightRepositoryProvider).getInsightsForWeek(displayWeek, locale);
    final weekDetail = ref.read(insightRepositoryProvider).getWeekDetail(displayWeek, locale);

    final isRu = locale == 'ru';
    final extendedInsights = [
      Insight(
        id: 'baby_dev_$displayWeek',
        type: InsightType.baby,
        title: isRu ? 'Развитие малыша' : 'Baby Development',
        content: weekDetail.babyDev,
        iconName: 'child_care',
      ),
      Insight(
        id: 'mom_body_$displayWeek',
        type: InsightType.body,
        title: isRu ? 'Ваше тело' : 'Your Body',
        content: weekDetail.momBody,
        iconName: 'accessibility_new',
      ),
      Insight(
        id: 'tip_$displayWeek',
        type: InsightType.action,
        title: isRu ? 'Совет недели' : 'Tip of the Week',
        content: weekDetail.tip,
        iconName: 'spa',
      ),
      ...insights,
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Breathing Background
          const BreathingBackground(),

          // 2. Main content
          Positioned.fill(
             child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await _saveLetter(displayWeek);
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: MediaQuery.of(context).padding.top + 70),
                    ),
                    
                    // HERO SECTION
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _openWeekPicker(realWeek),
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.weekLabel(displayWeek).toUpperCase(),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      letterSpacing: 4.0,
                                      fontSize: 14,
                                      color: mutedColor.withValues(alpha: 0.5),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down_rounded,
                                      size: 16,
                                      color: mutedColor.withValues(alpha: 0.3))
                                ],
                              ),
                            ),
                          ),
                          if (isBrowsingHistory)
                            GestureDetector(
                              onTap: () => _setDisplayedWeek(realWeek, realWeek),
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                                    Icon(Icons.history, size: 14, color: theme.primaryColor),
                                    const SizedBox(width: 4),
                                    Text(l10n.homeReturnToCurrent(realWeek),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: theme.primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])).animate().fadeIn().scale(),
                            ),
                          // Hero Sphere
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onHorizontalDragEnd: (details) => _handleSphereSwipe(displayWeek, realWeek, details),
                            child: LivingSphereDisplay(
                              week: displayWeek,
                              scale: 0.85,
                            ),
                          ),
                        ]
                      )
                    ),
                    
                    // BENTO BOX GRID
                    SliverToBoxAdapter(
                       child: _buildBentoTools(context, l10n),
                    ),
                    
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    
                    // TITLE & MILESTONE
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: primaryColor.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.auto_awesome_rounded, size: 11, color: primaryColor.withValues(alpha: 0.7)),
                                const SizedBox(width: 6),
                                Text(
                                  '${_trimesterLabel(displayWeek, locale).toUpperCase()}  ·  ${l10n.weekLabel(displayWeek).toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor.withValues(alpha: 0.8),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(Icons.auto_awesome_rounded, size: 11, color: primaryColor.withValues(alpha: 0.7)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              objectData.title,
                              style: theme.textTheme.displayLarge?.copyWith(fontSize: 32, height: 1.1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              objectData.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                height: 1.55,
                                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.72),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (weekDetail.milestone != null && weekDetail.milestone!.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: const EdgeInsets.symmetric(horizontal: 32),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: primaryColor.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.emoji_events_rounded, color: primaryColor, size: 22),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      weekDetail.milestone!,
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ]
                      )
                    ),
                    
                    const SliverToBoxAdapter(child: SizedBox(height: 28)),
                    SliverToBoxAdapter(
                      child: FetalGrowthSection(week: displayWeek),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 28)),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: WeekDetailInsightCard(
                                insight: extendedInsights[index],
                                iconData: _getIconFromName(extendedInsights[index].iconName),
                                staggerDelayMs: 0,
                              ),
                            );
                          },
                          childCount: extendedInsights.length,
                        ),
                      ),
                    ),
                    
                    SliverToBoxAdapter(
                       child: _buildLettersSection(context, l10n, displayWeek, settings.babyName),
                    ),
                    
                    const SliverToBoxAdapter(child: SizedBox(height: 120)),
                  ],
                ),
             )
          ),

          OrbitAppBar(
            settings: settings,
            isFruitMode: _visualModeKey == PregnancySettings.visualModeFruit,
            onToggleMode: _toggleVisualMode,
            onSettingsTap: () => _openSettings(settings),
            depthOpacity: 1.0,
          ),

          if (settings.showLaborButton)
            Positioned(
              top: MediaQuery.of(context).padding.top + 70,
              right: 16,
              child: LaborTriggerButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const LaborConfirmSheet(),
                  );
                },
              ),
            ),
            
          Positioned(
             bottom: 32,
             left: 24,
             right: 24,
             child: OrbitNavBar(
                labelHome: "Home",
                labelTools: l10n.toolGallery,
                labelDiary: l10n.connectionOpenDiary,
                onToolsTap: () {
                   _openSheet(const BumpGallerySheet()); 
                },
                onDiaryTap: () => _openSheet(const DiarySheet()),
             ),
          )
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool isSmall;

  const _BentoCard({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return GlassCard(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      padding: EdgeInsets.all(isSmall ? 16 : 20),
      borderRadius: 24,
      color: cardColor.withValues(alpha: 0.7),
      child: isSmall 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.black87, size: 20),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: mainTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.black87, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: mainTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 11, color: mutedColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
"""

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(new_content)
