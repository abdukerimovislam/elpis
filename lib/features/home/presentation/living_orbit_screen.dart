import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

import '../../../core/ui/glass_card.dart';
import '../../../core/ui/glass_text_field.dart';

import '../../health/presentation/tools_sheet.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/data/insight_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../settings/presentation/settings_sheet.dart';
import '../../pregnancy/presentation/diary_sheet.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import 'celestial_dial.dart';

import 'widgets/living_sphere_display.dart';
import 'widgets/orbit_navigation_ui.dart';

// --- ИМПОРТЫ ДЛЯ ЛОГИКИ РОДОВ ---
import '../../labor/presentation/labor_trigger_button.dart';
import '../../labor/presentation/labor_confirm_sheet.dart';

// --- ИМПОРТ ДЛЯ ВЫБОРА НЕДЕЛИ ---
import 'widgets/week_picker_sheet.dart';

class LivingOrbitScreen extends ConsumerStatefulWidget {
  const LivingOrbitScreen({super.key});

  @override
  ConsumerState<LivingOrbitScreen> createState() => _LivingOrbitScreenState();
}

class _LivingOrbitScreenState extends ConsumerState<LivingOrbitScreen> with SingleTickerProviderStateMixin {
  late AnimationController _depthController;
  final TextEditingController _letterController = TextEditingController();

  int? _overrideWeek;
  int? _lastLoadedLetterWeek;
  int _lastHapticState = 0;
  DateTime? _cachedDueDate;

  bool _isFruitMode = false;

  @override
  void initState() {
    super.initState();
    _depthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: -1.0,
      upperBound: 1.0,
      value: 0.0,
    );
    _depthController.addListener(_handleHaptics);
  }

  void _handleHaptics() {
    final value = _depthController.value;
    int newState = 0;
    if (value > 0.4) newState = 1;
    else if (value < -0.4) newState = -1;
    else newState = 0;

    if (newState != _lastHapticState) {
      if (newState != 0) HapticFeedback.mediumImpact();
      else HapticFeedback.selectionClick();
      _lastHapticState = newState;
    }
  }

  @override
  void dispose() {
    _depthController.removeListener(_handleHaptics);
    _depthController.dispose();
    _letterController.dispose();
    super.dispose();
  }

  void _onDragEnd(DragEndDetails details) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) return;
    final double velocity = details.velocity.pixelsPerSecond.dy;
    final double current = _depthController.value;
    double target = 0.0;

    if (velocity < -600) target = -1.0;
    else if (velocity > 600) target = 1.0;
    else {
      if (current > 0.3) target = 1.0;
      else if (current < -0.3) target = -1.0;
      else target = 0.0;
    }

    _depthController.animateTo(target, curve: Curves.easeOutCubic, duration: const Duration(milliseconds: 600));
  }

  // Метод для закрытия информационных слоев (возврат к сфере)
  void _resetView() {
    FocusScope.of(context).unfocus();
    _depthController.animateTo(0.0, curve: Curves.easeInOut, duration: const Duration(milliseconds: 500));
  }

  void _saveLetter(int week) {
    final text = _letterController.text;
    ref.read(pregnancyRepositoryProvider).saveLetter(week, text);
  }

  void _toggleVisualMode() {
    HapticFeedback.selectionClick();
    final repo = ref.read(pregnancyRepositoryProvider);
    repo.setFruitMode(!_isFruitMode);
    setState(() {
      _isFruitMode = !_isFruitMode;
    });
  }

  void _openSettings(PregnancySettings settings) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (c) => SettingsSheet(currentSettings: settings)
    );
  }

  void _openWeekPicker() async {
    HapticFeedback.selectionClick();
    final selectedWeek = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const WeekPickerSheet(),
    );

    if (selectedWeek != null && mounted) {
      setState(() {
        _overrideWeek = selectedWeek;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(pregnancyRepositoryProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    if (l10n == null) return Scaffold(backgroundColor: theme.scaffoldBackgroundColor);

    return StreamBuilder<PregnancySettings?>(
      stream: repository.watchSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(backgroundColor: theme.scaffoldBackgroundColor);
        }

        final settings = snapshot.data;
        if (settings == null) return const OnboardingScreen();

        if (_isFruitMode != settings.isFruitMode) {
          _isFruitMode = settings.isFruitMode;
        }

        if (_cachedDueDate != null && _cachedDueDate != settings.estimatedDueDate) {
          _overrideWeek = null;
          _letterController.clear();
          _lastLoadedLetterWeek = null;
        }
        _cachedDueDate = settings.estimatedDueDate;

        final realWeek = settings.currentWeek;
        final displayWeek = _overrideWeek ?? realWeek;
        final isBrowsingHistory = displayWeek != realWeek;

        if (_lastLoadedLetterWeek != displayWeek) {
          _lastLoadedLetterWeek = displayWeek;
          ref.read(pregnancyRepositoryProvider).getOrCreateSnapshot(displayWeek).then((snapshot) {
            if (mounted && _lastLoadedLetterWeek == displayWeek) {
              _letterController.text = snapshot.letterToBaby ?? "";
            }
          });
        }

        return AnimatedBuilder(
          animation: _depthController,
          builder: (context, child) {
            final depth = _depthController.value;

            // Если слой открыт, блокируем вертикальный свайп сферы
            final bool isContentOpen = depth.abs() > 0.15;

            final sphereScale = 1.0 - (depth.clamp(0.0, 1.0) * 0.3) + (depth.clamp(-1.0, 0.0).abs() * 0.2);
            final sphereBlur = (depth.clamp(0.0, 1.0) * 10.0);
            final sphereOffset = -depth * 80;
            final uiOpacity = (1.0 - depth.abs() * 3).clamp(0.0, 1.0);

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              resizeToAvoidBottomInset: false,
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: GestureDetector(
                onVerticalDragUpdate: isContentOpen ? null : (details) {
                  if (MediaQuery.of(context).viewInsets.bottom > 0) return;
                  _depthController.value -= details.primaryDelta! / 400;
                },
                onVerticalDragEnd: isContentOpen ? null : _onDragEnd,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _saveLetter(displayWeek);
                },

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const BreathingBackground(),

                    Positioned.fill(
                      child: Transform.translate(
                        offset: Offset(0, sphereOffset),
                        child: LivingSphereDisplay(
                          week: displayWeek,
                          scale: sphereScale,
                        ),
                      ),
                    ),

                    // КНОПКА ВЫБОРА НЕДЕЛИ
                    Positioned(
                      top: 130,
                      child: AnimatedOpacity(
                        duration: 200.ms,
                        opacity: uiOpacity,
                        child: GestureDetector(
                          onTap: _openWeekPicker,
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
                                    color: mutedColor.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 16,
                                    color: mutedColor.withOpacity(0.3)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    _buildCinematicInfoLayer(context, l10n, displayWeek, depth),
                    _buildLettersLayer(context, l10n, displayWeek, settings.babyName, depth),

                    // ЦИФЕРБЛАТ
                    if (MediaQuery.of(context).viewInsets.bottom == 0)
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: AnimatedOpacity(
                          duration: 200.ms,
                          opacity: (1.0 - depth.abs() * 5).clamp(0.0, 1.0),
                          child: IgnorePointer(
                            ignoring: depth.abs() > 0.1,
                            child: _buildDialArea(context, l10n, displayWeek, realWeek, isBrowsingHistory),
                          ),
                        ),
                      ),

                    _buildScrollHint(context, l10n, depth),

                    // APP BAR
                    OrbitAppBar(
                      settings: settings,
                      isFruitMode: _isFruitMode,
                      onToggleMode: _toggleVisualMode,
                      onSettingsTap: () => _openSettings(settings),
                      depthOpacity: uiOpacity,
                    ),

                    // 🔥 КНОПКА РОДОВ (НОВОЕ МЕСТО + ПРОВЕРКА НАСТРОЙКИ) 🔥
                    // Показываем, только если включено в настройках (showLaborButton)
                    if (settings.showLaborButton)
                      Positioned(
                        top: 110,
                        right: 16,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: isContentOpen ? 0.0 : 1.0,
                          child: IgnorePointer(
                            ignoring: isContentOpen,
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
                        ),
                      ),

                    OrbitNavBar(
                      labelHome: "Home",
                      labelTools: l10n.tabDetails,
                      labelDiary: l10n.connectionOpenDiary,
                      onToolsTap: () => showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (c) => const ToolsSheet()),
                      onDiaryTap: () => showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (c) => const DiarySheet()),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCinematicInfoLayer(BuildContext context, AppLocalizations l10n, int week, double depth) {
    if (depth <= 0.05) return const SizedBox();

    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final objectData = ref.read(insightRepositoryProvider).getObjectData(week, locale, _isFruitMode);
    final insights = ref.read(insightRepositoryProvider).getInsightsForWeek(week, locale);
    final slideUp = (1.0 - depth) * 500;
    final opacity = ((depth - 0.2) / 0.8).clamp(0.0, 1.0);

    return Positioned(
      top: 120, left: 0, right: 0, bottom: 0,
      child: Transform.translate(
        offset: Offset(0, slideUp),
        child: Opacity(
          opacity: opacity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Кнопка свернуть
                IconButton(
                    onPressed: _resetView,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                    )
                ),

                const SizedBox(height: 10),
                Text(
                    objectData.title,
                    style: theme.textTheme.displayLarge?.copyWith(fontSize: 42, height: 1.1),
                    textAlign: TextAlign.center
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                        objectData.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            height: 1.5,
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8)
                        ),
                        textAlign: TextAlign.center
                    )
                ),
                const SizedBox(height: 40),

                SizedBox(
                    height: 240,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: insights.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = insights[index];
                          final iconData = _getIconFromName(item.iconName);
                          return Center(
                              child: SizedBox(
                                  width: 200,
                                  height: 220,
                                  child: GlassCard(
                                      forceNoBlur: true,
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                          children: [
                                            Row(
                                                children: [
                                                  Icon(iconData, color: theme.textTheme.bodyMedium?.color, size: 22),
                                                  const SizedBox(width: 8),
                                                  Expanded(child: Text(item.title, style: theme.textTheme.labelSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1))
                                                ]
                                            ),
                                            const Spacer(),
                                            Text(
                                              item.content,
                                              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer()
                                          ]
                                      )
                                  )
                              )
                          );
                        }
                    )
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLettersLayer(BuildContext context, AppLocalizations l10n, int week, String? babyName, double depth) {
    if (depth >= 0) return const SizedBox();
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final opacity = ((depth.abs() - 0.1) / 0.9).clamp(0.0, 1.0);
    final offset = -150 * (1 + depth);

    return Positioned.fill(
      top: 100,
      child: IgnorePointer(
        ignoring: depth > -0.5,
        child: Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, offset),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: _resetView,
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                        child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black54),
                      )
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          (babyName != null && babyName.isNotEmpty) ? l10n.connectionTitleNamed(babyName) : l10n.connectionTitle,
                          style: theme.textTheme.displayLarge?.copyWith(fontSize: 24, color: mutedColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        GlassTextField(
                            controller: _letterController,
                            hintText: l10n.connectionPlaceholder,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              _saveLetter(week);
                            }
                        ),
                        const SizedBox(height: 16),
                        TextButton.icon(
                            onPressed: () { showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const DiarySheet()); },
                            icon: Icon(Icons.history_edu, size: 16, color: mutedColor),
                            label: Text(l10n.connectionOpenDiary, style: theme.textTheme.labelSmall?.copyWith(color: mutedColor))
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialArea(BuildContext context, AppLocalizations l10n, int displayWeek, int realWeek, bool isBrowsingHistory) {
    final theme = Theme.of(context);
    return Container(
      height: 250,
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isBrowsingHistory)
            GestureDetector(
              onTap: () => setState(() => _overrideWeek = null),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history, size: 14, color: theme.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                            l10n.homeReturnToCurrent(realWeek),
                            style: TextStyle(
                                fontSize: 12,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ]
                  )
              ).animate().fadeIn().scale(),
            ),
          Transform.scale(
              scale: 1.25,
              child: CelestialDial(
                  currentWeek: displayWeek,
                  realWeek: realWeek,
                  onWeekChanged: (week) => setState(() => _overrideWeek = week)
              )
          ),
        ],
      ),
    );
  }

  Widget _buildScrollHint(BuildContext context, AppLocalizations l10n, double depth) {
    if (depth.abs() > 0.05) return const SizedBox();
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    return Positioned(
        bottom: 260, left: 0, right: 0,
        child: IgnorePointer(
            child: Opacity(
                opacity: 0.8,
                child: Column(
                    children: [
                      Text(
                          l10n.tabDetails.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 10, letterSpacing: 2)
                      ),
                      const SizedBox(height: 4),
                      Icon(Icons.keyboard_arrow_up_rounded, color: mutedColor.withOpacity(0.5), size: 16)
                    ]
                )
            )
        )
    );
  }
}