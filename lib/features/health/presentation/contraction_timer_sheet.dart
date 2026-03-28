import 'dart:async';
import 'dart:ui'; // Ð”Ð»Ñ ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Ð”Ð»Ñ HapticFeedback
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../l10n/app_localizations.dart';
import '../data/contraction_repository.dart';
import '../domain/contraction.dart';

class ContractionTimerSheet extends ConsumerStatefulWidget {
  const ContractionTimerSheet({super.key});

  @override
  ConsumerState<ContractionTimerSheet> createState() =>
      _ContractionTimerSheetState();
}

class _ContractionTimerSheetState extends ConsumerState<ContractionTimerSheet>
    with TickerProviderStateMixin {
  Contraction? _activeContraction;
  Timer? _timer;

  // Ð¢Ð°Ð¹Ð¼ÐµÑ€ Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ
  Timer? _breathingTimer;
  bool _isInhaling = true;

  String _timerText = "00:00";

  // ÐÐ½Ð°Ð»Ð¸Ð· Ð¸ UI
  String? _customStatusMessage;
  Color _statusColor = Colors.white54;
  bool _showHospitalAlert = false;

  @override
  void initState() {
    super.initState();
    // Ð’ÐšÐ›Ð®Ð§ÐÐ•Ðœ WAKELOCK
    WakelockPlus.enable();
    _checkActive();
  }

  @override
  void dispose() {
    // Ð’Ð«ÐšÐ›Ð®Ð§ÐÐ•Ðœ WAKELOCK
    WakelockPlus.disable();
    _stopTimers();
    super.dispose();
  }

  Future<void> _checkActive() async {
    final active =
        await ref.read(contractionRepositoryProvider).getActiveContraction();
    if (active != null) {
      _resumeTimer(active);
    }
  }

  // Ð—Ð°Ð¿ÑƒÑÐº Ñ‚Ð°Ð¹Ð¼ÐµÑ€Ð° Ð¸ Ñ†Ð¸ÐºÐ»Ð° Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ
  void _resumeTimer(Contraction c) {
    setState(() {
      _activeContraction = c;
      _isInhaling = true;
    });

    // 1. ÐžÑÐ½Ð¾Ð²Ð½Ð¾Ð¹ Ñ‚Ð°Ð¹Ð¼ÐµÑ€ Ð²Ñ€ÐµÐ¼ÐµÐ½Ð¸
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = DateTime.now().difference(c.startTime);
      if (mounted) {
        setState(() {
          _timerText =
              "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
        });
      }
    });

    // 2. Ð¢Ð°Ð¹Ð¼ÐµÑ€ Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ (4 ÑÐµÐº Ð²Ð´Ð¾Ñ…, 4 ÑÐµÐº Ð²Ñ‹Ð´Ð¾Ñ…)
    _breathingTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() => _isInhaling = !_isInhaling);
        HapticFeedback.lightImpact();
      }
    });
  }

  void _stopTimers() {
    _timer?.cancel();
    _breathingTimer?.cancel();
  }

  Future<void> _clearHistory() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      _stopTimers();
      setState(() {
        _activeContraction = null;
        _timerText = "00:00";
        _isInhaling = true;
        _customStatusMessage = null;
        _statusColor = Colors.white54;
        _showHospitalAlert = false;
      });

      await ref.read(contractionRepositoryProvider).clearHistory();
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorGeneric)),
      );
    }
  }

  void _toggleTimer() async {
    final primaryColor = Theme.of(context).primaryColor;

    HapticFeedback.mediumImpact();

    if (_activeContraction == null) {
      // Ð¡Ð¢ÐÐ Ð¢
      final c =
          await ref.read(contractionRepositoryProvider).startContraction();
      _resumeTimer(c);
      _showHospitalAlert = false;
    } else {
      // Ð¡Ð¢ÐžÐŸ
      await ref
          .read(contractionRepositoryProvider)
          .stopContraction(_activeContraction!.id);
      _stopTimers();

      setState(() {
        _activeContraction = null;
        _timerText = "00:00";
        _isInhaling = true;
      });

      _analyzeSituation(primaryColor);
    }
  }

  Future<void> _analyzeSituation(Color primaryColor) async {
    final l10n = AppLocalizations.of(context)!;

    // ÐŸÐ¾Ð»ÑƒÑ‡Ð°ÐµÐ¼ Ð¸ÑÑ‚Ð¾Ñ€Ð¸ÑŽ
    final history =
        await ref.read(contractionRepositoryProvider).watchHistory().first;

    bool isUrgent = _check511Rule(history);

    setState(() {
      if (isUrgent) {
        _customStatusMessage =
            l10n.contractionAlertMessage; // Ð˜Ð¡ÐŸÐ ÐÐ’Ð›Ð•ÐÐž
        _statusColor = const Color(0xFFF56C6C);
        _showHospitalAlert = true;
      } else {
        _customStatusMessage = l10n.contractionRelax;
        _statusColor = primaryColor;
        _showHospitalAlert = false;
      }
    });
  }

  bool _check511Rule(List<Contraction> history) {
    if (history.length < 3) return false;
    final recent = history.take(3).toList();

    bool durationCondition = recent
        .every((c) => (c.endTime?.difference(c.startTime).inSeconds ?? 0) > 45);

    bool intervalCondition = true;
    for (int i = 0; i < recent.length - 1; i++) {
      final diff =
          recent[i].startTime.difference(recent[i + 1].startTime).inMinutes;
      if (diff > 6 || diff < 3) intervalCondition = false;
    }

    return durationCondition && intervalCondition;
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _activeContraction != null;
    final historyAsync =
        ref.watch(contractionRepositoryProvider).watchHistory();

    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    final statusText = _customStatusMessage ?? l10n.contractionInstruction;

    // Ð˜Ð¡ÐŸÐ ÐÐ’Ð›Ð•ÐÐž: Ð¢ÐµÐºÑÑ‚ Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ Ñ‚ÐµÐ¿ÐµÑ€ÑŒ Ð»Ð¾ÐºÐ°Ð»Ð¸Ð·Ð¾Ð²Ð°Ð½
    final breathingText =
        _isInhaling ? l10n.contractionBreathIn : l10n.contractionBreathOut;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white30),
            onPressed: _clearHistory,
          )
        ],
      ),
      body: Stack(
        children: [
          // 1. Ð–Ð˜Ð’ÐžÐ™ Ð¤ÐžÐ
          AnimatedContainer(
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: isRunning ? (_isInhaling ? 1.2 : 0.8) : 0.6,
                colors: [
                  isRunning
                      ? primaryColor.withValues(alpha: 0.15)
                      : Colors.transparent,
                  const Color(0xFF121212),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // 2. ÐžÐ¡ÐÐžÐ’ÐÐžÐ™ ÐšÐžÐÐ¢Ð•ÐÐ¢
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ð¢Ð Ð•Ð’ÐžÐ–ÐÐÐ¯ ÐŸÐ›ÐÐ¨ÐšÐ (5-1-1)
                      if (_showHospitalAlert)
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF56C6C)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFFF56C6C)
                                      .withValues(alpha: 0.5))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.warning_amber_rounded,
                                  color: Color(0xFFF56C6C), size: 18),
                              const SizedBox(width: 8),
                              Text(
                                  l10n
                                      .contractionAlertTitle, // Ð˜Ð¡ÐŸÐ ÐÐ’Ð›Ð•ÐÐž
                                  style: theme.textTheme.labelSmall?.copyWith(
                                      color: const Color(0xFFF56C6C),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ).animate().fadeIn().slideY(begin: -1, end: 0),

                      // Ð¡Ð¢ÐÐ¢Ð£Ð¡
                      Text(
                          isRunning
                              ? l10n.contractionLabelActive
                              : l10n.contractionLabelRest,
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white38, letterSpacing: 4)),
                      const SizedBox(height: 30),

                      // ÐŸÐ£Ð›Ð¬Ð¡Ð˜Ð Ð£Ð®Ð©ÐÐ¯ ÐšÐÐžÐŸÐšÐ
                      GestureDetector(
                        onTap: _toggleTimer,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 4),
                          curve: Curves.easeInOut,
                          width: isRunning ? (_isInhaling ? 300 : 260) : 240,
                          height: isRunning ? (_isInhaling ? 300 : 260) : 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isRunning
                                ? primaryColor.withValues(alpha: 0.15)
                                : const Color(0xFF2C2C2C),
                            border: Border.all(
                                color: isRunning
                                    ? primaryColor.withValues(alpha: 0.6)
                                    : Colors.white10,
                                width: isRunning ? 2 : 1),
                            boxShadow: isRunning
                                ? [
                                    BoxShadow(
                                        color:
                                            primaryColor.withValues(alpha: 0.2),
                                        blurRadius: 50,
                                        spreadRadius: 10)
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Ð’Ñ€ÐµÐ¼Ñ
                                Text(
                                  _timerText,
                                  style: const TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 56,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                ),
                                const SizedBox(height: 8),

                                // Ð¢ÐµÐºÑÑ‚ Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ Ð¸Ð»Ð¸ ÑÑ‚Ð°Ñ€Ñ‚
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: isRunning
                                      ? Text(
                                          breathingText.toUpperCase(),
                                          key: ValueKey(_isInhaling),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2),
                                        )
                                      : Text(
                                          l10n.contractionBtnStart,
                                          key: const ValueKey("Start"),
                                          style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Ð¡Ñ‚Ð°Ñ‚ÑƒÑ / Ð¡Ð¾Ð²ÐµÑ‚
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          statusText,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: _statusColor == Colors.white54
                                  ? Colors.white54
                                  : primaryColor,
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ÐÐ˜Ð–ÐÐ¯Ð¯ Ð§ÐÐ¡Ð¢Ð¬ (Ð˜ÑÑ‚Ð¾Ñ€Ð¸Ñ)
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E).withValues(alpha: 0.7),
                        border: Border(
                            top: BorderSide(
                                color: Colors.white.withValues(alpha: 0.05))),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(l10n.contractionHistory,
                                  style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5)),
                              if (_activeContraction != null)
                                Text(
                                    l10n
                                        .contractionTapToStop, // Ð˜Ð¡ÐŸÐ ÐÐ’Ð›Ð•ÐÐž
                                    style: TextStyle(
                                        color:
                                            primaryColor.withValues(alpha: 0.5),
                                        fontSize: 10)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(l10n.contractionColStart,
                                      style: const TextStyle(
                                          color: Colors.white30,
                                          fontSize: 12))),
                              Expanded(
                                  child: Text(l10n.contractionColDuration,
                                      style: const TextStyle(
                                          color: Colors.white30,
                                          fontSize: 12))),
                              Expanded(
                                  child: Text(l10n.contractionColInterval,
                                      style: const TextStyle(
                                          color: Colors.white30,
                                          fontSize: 12))),
                            ],
                          ),
                          const Divider(color: Colors.white10),
                          Expanded(
                            child: StreamBuilder<List<Contraction>>(
                              stream: historyAsync,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                      child: Text(l10n.contractionEmpty,
                                          style: const TextStyle(
                                              color: Colors.white12)));
                                }

                                final list = snapshot.data!;
                                return ListView.separated(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  itemCount: list.length,
                                  separatorBuilder: (_, __) => const Divider(
                                      color: Colors.white10, height: 1),
                                  itemBuilder: (context, index) {
                                    final item = list[index];
                                    if (item.endTime == null &&
                                        item.id == _activeContraction?.id) {
                                      return const SizedBox();
                                    }
                                    String interval = "-";
                                    if (index < list.length - 1) {
                                      final prev = list[index + 1];
                                      final diff = item.startTime
                                          .difference(prev.startTime)
                                          .inMinutes;
                                      interval = "$diff ${l10n.commonMin}";
                                    }

                                    final isLong = item.durationInSeconds > 45;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  DateFormat('HH:mm', locale)
                                                      .format(item.startTime),
                                                  style: const TextStyle(
                                                      color: Colors.white70))),
                                          Expanded(
                                              child: Text(
                                                  "${item.durationInSeconds} ${l10n.commonSec}",
                                                  style: TextStyle(
                                                      color: isLong
                                                          ? const Color(
                                                              0xFFF56C6C)
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Expanded(
                                              child: Text(interval,
                                                  style: const TextStyle(
                                                      color: Colors.white54))),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
