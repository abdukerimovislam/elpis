import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/glass_card.dart';
import '../../../core/ui/glass_text_field.dart';
import '../../../l10n/app_localizations.dart';
import '../../health/presentation/care_center_screen.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../pregnancy/data/insight_repository.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/insight.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../pregnancy/presentation/diary_sheet.dart';
import '../../pregnancy/presentation/widgets/fetal_growth_section.dart';
import '../../settings/presentation/settings_sheet.dart';
import '../../subscription/presentation/paywall_sheet.dart';
import 'widgets/home_context_snapshot.dart';
import 'widgets/home_mini_calendar.dart';
import 'widgets/home_today_card.dart';
import 'widgets/living_sphere_display.dart';
import 'widgets/orbit_navigation_ui.dart';
import 'widgets/week_detail_insight_card.dart';
import 'widgets/week_picker_sheet.dart';
import '../../../core/ui/holographic_background.dart';

final orbitSettingsProvider =
    StreamProvider.autoDispose<PregnancySettings?>((ref) {
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
  Timer? _letterSaveDebounce;
  _QueuedLetterSave? _queuedLetterSave;
  String _visualModeKey = PregnancySettings.visualModeFruit;
  bool _isSavingLetter = false;
  bool _isTogglingVisualMode = false;
  String _loadedLetterText = "";
  _LetterSaveState _letterSaveState = _LetterSaveState.idle;

  @override
  void dispose() {
    _letterSaveDebounce?.cancel();
    _letterController.dispose();
    super.dispose();
  }

  int get _currentRealWeek =>
      ref.read(orbitSettingsProvider).valueOrNull?.currentWeek ?? 1;

  int get _currentDisplayWeek => _overrideWeek ?? _currentRealWeek;

  void _setDisplayedWeek(int week, int realWeek) {
    final safeWeek = week.clamp(1, 42);
    final previousWeek = _currentDisplayWeek;
    final previousText = _letterController.text;

    _letterSaveDebounce?.cancel();
    if (previousWeek != safeWeek && previousText != _loadedLetterText) {
      _persistLetter(previousWeek, previousText, updateStatus: false);
    }

    setState(() {
      _overrideWeek = safeWeek == realWeek ? null : safeWeek;
    });
    _loadLetter(safeWeek);
  }

  void _handleSphereSwipe(
    int displayWeek,
    int realWeek,
    DragEndDetails details,
  ) {
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
      final snapshot =
          await ref.read(pregnancyRepositoryProvider).getOrCreateSnapshot(week);
      if (!mounted || _lastLoadedLetterWeek != week) return;

      final letter = snapshot.letterToBaby ?? "";
      setState(() {
        _loadedLetterText = letter;
        _letterController.text = letter;
        _letterSaveState =
            letter.isEmpty ? _LetterSaveState.idle : _LetterSaveState.saved;
      });
    } catch (_) {
      if (!mounted || _lastLoadedLetterWeek != week) return;
      _showErrorSnack(
        AppLocalizations.of(context)?.errorGeneric ??
            "Something went wrong. Please try again.",
      );
    }
  }

  Future<void> _persistLetter(
    int week,
    String text, {
    bool updateStatus = true,
  }) async {
    if (_isSavingLetter) {
      _queuedLetterSave = _QueuedLetterSave(
        week: week,
        text: text,
        updateStatus: updateStatus,
      );
      return;
    }
    if (text == _loadedLetterText && week == _currentDisplayWeek) {
      if (mounted && updateStatus) {
        setState(() {
          _letterSaveState =
              text.isEmpty ? _LetterSaveState.idle : _LetterSaveState.saved;
        });
      }
      return;
    }

    if (mounted && updateStatus && week == _currentDisplayWeek) {
      setState(() => _letterSaveState = _LetterSaveState.saving);
    }
    setState(() => _isSavingLetter = true);

    try {
      await ref.read(pregnancyRepositoryProvider).saveLetter(week, text);
      if (!mounted) return;

      if (week == _currentDisplayWeek) {
        setState(() {
          _loadedLetterText = text;
          if (updateStatus) {
            _letterSaveState =
                text.isEmpty ? _LetterSaveState.idle : _LetterSaveState.saved;
          }
        });
      }
    } catch (_) {
      if (mounted && updateStatus && week == _currentDisplayWeek) {
        setState(() => _letterSaveState = _LetterSaveState.error);
      }
      if (mounted) {
        _showErrorSnack(
          AppLocalizations.of(context)?.errorGeneric ??
              "Something went wrong. Please try again.",
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSavingLetter = false);
      }
      final queuedSave = _queuedLetterSave;
      _queuedLetterSave = null;
      if (queuedSave != null && mounted) {
        _persistLetter(
          queuedSave.week,
          queuedSave.text,
          updateStatus: queuedSave.updateStatus,
        );
      }
    }
  }

  Future<void> _saveLetter(int week) async {
    _letterSaveDebounce?.cancel();
    final text = _letterController.text;
    await _persistLetter(week, text);
  }

  void _handleLetterChanged(int week, String value) {
    _letterSaveDebounce?.cancel();
    setState(() {
      _letterSaveState = value == _loadedLetterText
          ? (value.isEmpty ? _LetterSaveState.idle : _LetterSaveState.saved)
          : _LetterSaveState.dirty;
    });

    if (value == _loadedLetterText) return;
    _letterSaveDebounce = Timer(
      const Duration(milliseconds: 900),
      () => _persistLetter(week, value),
    );
  }

  Future<void> _setVisualMode(String modeKey) async {
    if (_isTogglingVisualMode || _visualModeKey == modeKey) return;

    final previousMode = _visualModeKey;
    setState(() {
      _visualModeKey = modeKey;
      _isTogglingVisualMode = true;
    });

    try {
      await ref.read(pregnancyRepositoryProvider).setVisualMode(modeKey);
    } catch (_) {
      if (mounted) {
        setState(() {
          _visualModeKey = previousMode;
        });
        _showErrorSnack(
          AppLocalizations.of(context)?.errorGeneric ??
              "Something went wrong. Please try again.",
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
      builder: (c) => SettingsSheet(currentSettings: settings),
    );
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

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'water_drop':
        return Icons.water_drop_outlined;
      case 'local_hospital':
        return Icons.local_hospital_outlined;
      case 'favorite':
        return Icons.favorite_border;
      case 'favorite_border':
        return Icons.favorite_border;
      case 'psychology':
        return Icons.psychology_outlined;
      case 'accessibility_new':
        return Icons.accessibility_new_outlined;
      case 'accessibility':
        return Icons.accessibility_new_outlined;
      case 'self_improvement':
        return Icons.self_improvement_outlined;
      case 'moving':
        return Icons.moving_outlined;
      case 'medication':
        return Icons.medication_outlined;
      case 'update':
        return Icons.update_rounded;
      case 'spa':
        return Icons.spa_outlined;
      case 'child_care':
        return Icons.child_care;
      default:
        return Icons.info_outline;
    }
  }

  String _trimesterLabel(int week, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (week <= 13) return l10n.trimesterFirst;
    if (week <= 26) return l10n.trimesterSecond;
    return l10n.trimesterThird;
  }

  String _cozyMilestoneTitle(BuildContext context) {
    return AppLocalizations.of(context)!.insightBabyDevTitle;
  }

  ({String title, String body}) _todayFocus(
    int week,
    String languageCode,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;

    if (hour < 12) {
      if (week <= 13) {
        return (
          title: l10n.todayFocusMorningEarlyTitle,
          body: l10n.todayFocusMorningEarlyBody,
        );
      }
      if (week <= 26) {
        return (
          title: l10n.todayFocusMorningMidTitle,
          body: l10n.todayFocusMorningMidBody,
        );
      }
      return (
        title: l10n.todayFocusMorningLateTitle,
        body: l10n.todayFocusMorningLateBody,
      );
    }

    if (hour < 18) {
      if (week <= 13) {
        return (
          title: l10n.todayFocusDayEarlyTitle,
          body: l10n.todayFocusDayEarlyBody,
        );
      }
      if (week <= 26) {
        return (
          title: l10n.todayFocusDayMidTitle,
          body: l10n.todayFocusDayMidBody,
        );
      }
      return (
        title: l10n.todayFocusDayLateTitle,
        body: l10n.todayFocusDayLateBody,
      );
    }

    if (week <= 13) {
      return (
        title: l10n.todayFocusEveningEarlyTitle,
        body: l10n.todayFocusEveningEarlyBody,
      );
    }
    if (week <= 26) {
      return (
        title: l10n.todayFocusEveningMidTitle,
        body: l10n.todayFocusEveningMidBody,
      );
    }
    return (
      title: l10n.todayFocusEveningLateTitle,
      body: l10n.todayFocusEveningLateBody,
    );
  }

  String _letterSaveLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (_letterSaveState) {
      case _LetterSaveState.dirty:
        return l10n.letterStateDraft;
      case _LetterSaveState.saving:
        return l10n.letterStateSaving;
      case _LetterSaveState.saved:
        return l10n.letterStateSaved;
      case _LetterSaveState.error:
        return l10n.letterStateError;
      case _LetterSaveState.idle:
        return l10n.connectionPlaceholder;
    }
  }

  Widget _buildLettersSection(
    BuildContext context,
    AppLocalizations l10n,
    int week,
    String? babyName,
  ) {
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final primaryColor = theme.primaryColor;

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
              style: theme.textTheme.displayLarge
                  ?.copyWith(fontSize: 22, color: mutedColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GlassTextField(
              controller: _letterController,
              hintText: l10n.connectionPlaceholder,
              onChanged: (value) => _handleLetterChanged(week, value),
              onEditingComplete: () async {
                FocusScope.of(context).unfocus();
                await _saveLetter(week);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _letterSaveLabel(context),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: switch (_letterSaveState) {
                        _LetterSaveState.error =>
                          Theme.of(context).colorScheme.error,
                        _LetterSaveState.saved =>
                          primaryColor.withValues(alpha: 0.78),
                        _LetterSaveState.saving =>
                          primaryColor.withValues(alpha: 0.68),
                        _LetterSaveState.dirty =>
                          mutedColor.withValues(alpha: 0.86),
                        _LetterSaveState.idle =>
                          mutedColor.withValues(alpha: 0.72),
                      },
                      fontWeight: _letterSaveState == _LetterSaveState.saved
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _openSheet(const DiarySheet());
                  },
                  icon: Icon(Icons.history_edu, size: 16, color: mutedColor),
                  label: Text(
                    l10n.connectionOpenDiary,
                    style:
                        theme.textTheme.labelSmall?.copyWith(color: mutedColor),
                  ),
                ),
              ],
            ),
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

    if (l10n == null) {
      return Scaffold(backgroundColor: theme.scaffoldBackgroundColor);
    }

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
            _letterSaveState = _LetterSaveState.idle;
          });
        }

        if (currentWeek != null && _lastLoadedLetterWeek == null) {
          _loadLetter(_overrideWeek ?? currentWeek);
        }
      },
    );

    final settingsAsync = ref.watch(orbitSettingsProvider);

    if (settingsAsync.isLoading && !settingsAsync.hasValue) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            const HolographicBackground(),
            Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
                strokeWidth: 2.4,
              ),
            ),
          ],
        ),
      );
    }

    final settings = settingsAsync.valueOrNull;
    if (settings == null) return const OnboardingScreen();

    final settingsVisualMode = settings.effectiveVisualModeKey;
    if (!_isTogglingVisualMode && _visualModeKey != settingsVisualMode) {
      _visualModeKey = settingsVisualMode;
    }

    final topPadding = MediaQuery.paddingOf(context).top;
    final realWeek = settings.currentWeek;
    final displayWeek = _overrideWeek ?? realWeek;
    final isBrowsingHistory = displayWeek != realWeek;

    final objectData = ref
        .read(insightRepositoryProvider)
        .getObjectData(displayWeek, locale, _visualModeKey);
    final insights = ref
        .read(insightRepositoryProvider)
        .getInsightsForWeek(displayWeek, locale);
    final weekDetail =
        ref.read(insightRepositoryProvider).getWeekDetail(displayWeek, locale);
    final progressValue = (displayWeek / 42).clamp(0.0, 1.0);
    final todayFocus = _todayFocus(displayWeek, locale);

    final extendedInsights = [
      Insight(
        id: 'baby_dev_$displayWeek',
        type: InsightType.baby,
        title: l10n.insightBabyDevTitle,
        content: weekDetail.babyDev,
        iconName: 'child_care',
      ),
      Insight(
        id: 'mom_body_$displayWeek',
        type: InsightType.body,
        title: l10n.insightYourBodyTitle,
        content: weekDetail.momBody,
        iconName: 'accessibility_new',
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
          const HolographicBackground(),
          Positioned.fill(
            child: GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await _saveLetter(displayWeek);
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, topPadding + 76, 24, 28),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _openWeekPicker(realWeek),
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
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
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 16,
                                    color: mutedColor.withValues(alpha: 0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isBrowsingHistory)
                            GestureDetector(
                              onTap: () =>
                                  _setDisplayedWeek(realWeek, realWeek),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      theme.primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 14,
                                      color: theme.primaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      l10n.homeReturnToCurrent(realWeek),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn().scale(),
                            ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onHorizontalDragEnd: (details) =>
                                _handleSphereSwipe(
                              displayWeek,
                              realWeek,
                              details,
                            ),
                            child: LivingSphereDisplay(
                              week: displayWeek,
                              scale: 1.02,
                              showModeToggle: false,
                            ),
                          ),
                          const SizedBox(height: 14),
                          MiniWeekNavigator(
                            displayWeek: displayWeek,
                            realWeek: realWeek,
                            showLaborEntry: settings.showLaborButton,
                            locale: locale,
                            visualModeKey: _visualModeKey,
                            isTogglingVisualMode: _isTogglingVisualMode,
                            onWeekSelected: (week) =>
                                _setDisplayedWeek(week, realWeek),
                            onOpenWeekPicker: () => _openWeekPicker(realWeek),
                            onVisualModeSelected: _setVisualMode,
                          ).animate().fadeIn(duration: 480.ms).moveY(
                                begin: 10,
                                end: 0,
                                duration: 480.ms,
                                curve: Curves.easeOutCubic,
                              ),
                          const SizedBox(height: 18),
                          HomeContextSnapshot(
                            displayWeek: displayWeek,
                            locale: locale,
                            title: objectData.title,
                            description: objectData.description,
                            progressValue: progressValue,
                            trimesterLabel:
                                _trimesterLabel(displayWeek, context),
                            weekLabel: l10n.weekLabel(displayWeek),
                          ).animate().fadeIn(duration: 500.ms).moveY(
                                begin: -10,
                                end: 0,
                                duration: 500.ms,
                                curve: Curves.easeOutCubic,
                              ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.92),
                              theme.scaffoldBackgroundColor,
                              theme.scaffoldBackgroundColor,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.08),
                              blurRadius: 28,
                              offset: const Offset(0, -8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              width: 40,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 18),
                            TodayForYouCard(
                              focusTitle: todayFocus.title,
                              focusBody: todayFocus.body,
                              weeklyTip: weekDetail.tip,
                            ).animate().fadeIn(duration: 480.ms).moveY(
                                  begin: 12,
                                  end: 0,
                                  duration: 480.ms,
                                  curve: Curves.easeOutCubic,
                                ),
                            const SizedBox(height: 8),
                            if (weekDetail.milestone != null &&
                                weekDetail.milestone!.isNotEmpty) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _cozyMilestoneTitle(context),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: mutedColor.withValues(alpha: 0.82),
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.82),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: primaryColor.withValues(alpha: 0.18),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          primaryColor.withValues(alpha: 0.08),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.emoji_events_rounded,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        weekDetail.milestone!,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
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
                            const SizedBox(height: 28),
                            FetalGrowthSection(week: displayWeek),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0;
                                i < extendedInsights.length;
                                i++) ...[
                              WeekDetailInsightCard(
                                insight: extendedInsights[i],
                                iconData: _getIconFromName(
                                  extendedInsights[i].iconName,
                                ),
                                staggerDelayMs: 120 + (i * 40),
                              ),
                              if (i != extendedInsights.length - 1)
                                const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      child: _buildLettersSection(
                        context,
                        l10n,
                        displayWeek,
                        settings.babyName,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      child: SizedBox(
                        height: 120 + MediaQuery.viewInsetsOf(context).bottom,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          OrbitAppBar(
            settings: settings,
            onSettingsTap: () => _openSettings(settings),
            onProTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const PaywallSheet(),
              );
            },
            depthOpacity: 1.0,
          ),
          OrbitNavBar(
            labelHome: l10n.navHome,
            labelTools: l10n.navCare,
            labelDiary: l10n.navDiary,
            onToolsTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CareCenterScreen()),
              );
            },
            onDiaryTap: () => _openSheet(const DiarySheet()),
          ),
        ],
      ),
    );
  }
}

enum _LetterSaveState {
  idle,
  dirty,
  saving,
  saved,
  error,
}

class _QueuedLetterSave {
  final int week;
  final String text;
  final bool updateStatus;

  const _QueuedLetterSave({
    required this.week,
    required this.text,
    required this.updateStatus,
  });
}
