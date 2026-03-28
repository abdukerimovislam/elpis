import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wakelock_plus/wakelock_plus.dart'; // ÐÐµ Ð·Ð°Ð±Ñ‹Ð²Ð°ÐµÐ¼ Ð¿Ñ€Ð¾ Wakelock
import '../../../l10n/app_localizations.dart';

enum KegelPhase { idle, squeeze, relax, finished, paused }

class KegelSheet extends StatefulWidget {
  const KegelSheet({super.key});

  @override
  State<KegelSheet> createState() => _KegelSheetState();
}

class _KegelSheetState extends State<KegelSheet>
    with SingleTickerProviderStateMixin {
  // ÐÐ°ÑÑ‚Ñ€Ð¾Ð¹ÐºÐ¸ (Ð¿Ð¾ ÑƒÐ¼Ð¾Ð»Ñ‡Ð°Ð½Ð¸ÑŽ)
  int _squeezeDuration = 5;
  int _relaxDuration = 5;
  int _totalReps = 10;

  // Ð¡Ð¾ÑÑ‚Ð¾ÑÐ½Ð¸Ðµ
  KegelPhase _phase = KegelPhase.idle;
  KegelPhase _previousPhase =
      KegelPhase.idle; // Ð§Ñ‚Ð¾Ð±Ñ‹ Ð²ÐµÑ€Ð½ÑƒÑ‚ÑŒÑÑ Ð¿Ð¾ÑÐ»Ðµ Ð¿Ð°ÑƒÐ·Ñ‹
  int _timeLeft = 0;
  int _currentRep = 1;
  Timer? _timer;

  // Ð”Ð»Ñ Ð°Ð½Ð¸Ð¼Ð°Ñ†Ð¸Ð¸ Ð¿Ñ€Ð¾Ð³Ñ€ÐµÑÑÐ°
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _pulseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  // --- Ð›ÐžÐ“Ð˜ÐšÐ Ð¢ÐÐ™ÐœÐ•Ð Ð ---

  void _startTraining() {
    setState(() {
      _currentRep = 1;
      _startPhase(KegelPhase.squeeze);
    });
  }

  void _togglePause() {
    if (_phase == KegelPhase.finished || _phase == KegelPhase.idle) return;

    if (_phase == KegelPhase.paused) {
      // Ð’Ð¾Ð·Ð¾Ð±Ð½Ð¾Ð²Ð»ÑÐµÐ¼
      _resumeTimer();
    } else {
      // Ð¡Ñ‚Ð°Ð²Ð¸Ð¼ Ð½Ð° Ð¿Ð°ÑƒÐ·Ñƒ
      _timer?.cancel();
      _pulseController.stop();
      setState(() {
        _previousPhase = _phase;
        _phase = KegelPhase.paused;
      });
    }
  }

  void _resumeTimer() {
    setState(() => _phase = _previousPhase);
    _pulseController.repeat(reverse: true);
    // Ð—Ð°Ð¿ÑƒÑÐºÐ°ÐµÐ¼ Ñ‚Ð°Ð¹Ð¼ÐµÑ€ Ñ Ð¾ÑÑ‚Ð°Ð²ÑˆÐµÐ³Ð¾ÑÑ Ð²Ñ€ÐµÐ¼ÐµÐ½Ð¸
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
  }

  void _startPhase(KegelPhase nextPhase) {
    setState(() {
      _phase = nextPhase;
      if (_phase == KegelPhase.squeeze) {
        _timeLeft = _squeezeDuration;
        HapticFeedback.heavyImpact();
        _pulseController.repeat(
            reverse: true); // ÐŸÑƒÐ»ÑŒÑÐ°Ñ†Ð¸Ñ Ð¿Ñ€Ð¸ Ð½Ð°Ð¿Ñ€ÑÐ¶ÐµÐ½Ð¸Ð¸
      } else if (_phase == KegelPhase.relax) {
        _timeLeft = _relaxDuration;
        HapticFeedback.lightImpact();
        _pulseController.stop();
        _pulseController.value = 0.0; // Ð¡Ð±Ñ€Ð¾Ñ Ð°Ð½Ð¸Ð¼Ð°Ñ†Ð¸Ð¸
      }
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
  }

  void _tick() {
    setState(() {
      if (_timeLeft > 1) {
        _timeLeft--;
      } else {
        _nextStep();
      }
    });
  }

  void _nextStep() {
    _timer?.cancel();

    if (_phase == KegelPhase.squeeze) {
      // ÐŸÐ¾ÑÐ»Ðµ ÑÐ¶Ð°Ñ‚Ð¸Ñ -> Ð¾Ñ‚Ð´Ñ‹Ñ…
      _startPhase(KegelPhase.relax);
    } else if (_phase == KegelPhase.relax) {
      // ÐŸÐ¾ÑÐ»Ðµ Ð¾Ñ‚Ð´Ñ‹Ñ…Ð° -> Ð»Ð¸Ð±Ð¾ Ð½Ð¾Ð²Ð¾Ðµ ÑÐ¶Ð°Ñ‚Ð¸Ðµ, Ð»Ð¸Ð±Ð¾ ÐºÐ¾Ð½ÐµÑ†
      if (_currentRep < _totalReps) {
        setState(() => _currentRep++);
        _startPhase(KegelPhase.squeeze);
      } else {
        _finishTraining();
      }
    }
  }

  void _finishTraining() {
    setState(() {
      _phase = KegelPhase.finished;
    });
    HapticFeedback.mediumImpact();
    // ÐœÐ¾Ð¶Ð½Ð¾ ÑÐ¾Ñ…Ñ€Ð°Ð½Ð¸Ñ‚ÑŒ Ñ€ÐµÐ·ÑƒÐ»ÑŒÑ‚Ð°Ñ‚ Ð² Ð±Ð°Ð·Ñƒ Ð´Ð°Ð½Ð½Ñ‹Ñ… Ð·Ð´ÐµÑÑŒ
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _phase = KegelPhase.idle;
      _currentRep = 1;
      _timeLeft = 0;
    });
  }

  // --- ÐÐÐ¡Ð¢Ð ÐžÐ™ÐšÐ˜ ---
  void _showSettings(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Ð’Ñ€ÐµÐ¼ÐµÐ½Ð½Ñ‹Ðµ Ð¿ÐµÑ€ÐµÐ¼ÐµÐ½Ð½Ñ‹Ðµ
    int tempSqueeze = _squeezeDuration;
    int tempRelax = _relaxDuration;
    int tempReps = _totalReps;

    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (ctx) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.kegelSettingsTitle,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 24),
                  _buildSlider(context, l10n.kegelSettingWork, tempSqueeze, 1,
                      15, (val) => setModalState(() => tempSqueeze = val)),
                  _buildSlider(context, l10n.kegelSettingRest, tempRelax, 1, 15,
                      (val) => setModalState(() => tempRelax = val)),
                  _buildSlider(context, l10n.kegelSettingReps, tempReps, 5, 50,
                      (val) => setModalState(() => tempReps = val)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _squeezeDuration = tempSqueeze;
                          _relaxDuration = tempRelax;
                          _totalReps = tempReps;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(l10n.commonSave),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  Widget _buildSlider(BuildContext context, String title, int value, double min,
      double max, Function(int) onChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text("$value", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (val) => onChanged(val.toInt()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- Ð¢Ð•ÐœÐ˜Ð—ÐÐ¦Ð˜Ð¯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;

    // ÐŸÐ°Ñ€Ð°Ð¼ÐµÑ‚Ñ€Ñ‹ UI
    String title;
    String subtitle;
    double sphereScale; // 1.0 = Ð½Ð¾Ñ€Ð¼Ð°, 0.7 = ÑÐ¶Ð°Ñ‚Ð¸Ðµ
    Color sphereColor;
    bool showTimer = false;

    switch (_phase) {
      case KegelPhase.idle:
        title = l10n.kegelTitle;
        subtitle = l10n.kegelSubtitle;
        sphereScale = 1.0;
        sphereColor = primaryColor.withValues(alpha: 0.1);
        break;
      case KegelPhase.squeeze:
        title = l10n.kegelPhaseSqueeze;
        subtitle = l10n.kegelPhaseSqueezeInstr;
        sphereScale = 0.65; // Ð’Ð¸Ð·ÑƒÐ°Ð»ÑŒÐ½Ð¾ ÑÐ¶Ð¸Ð¼Ð°ÐµÐ¼
        sphereColor = const Color(
            0xFFFFCCBC); // Ð¢ÐµÐ¿Ð»Ñ‹Ð¹ Ñ†Ð²ÐµÑ‚ Ð½Ð°Ð¿Ñ€ÑÐ¶ÐµÐ½Ð¸Ñ
        showTimer = true;
        break;
      case KegelPhase.relax:
        title = l10n.kegelPhaseRelax;
        subtitle = l10n.kegelPhaseRelaxInstr;
        sphereScale = 1.1; // Ð Ð°ÑÑÐ»Ð°Ð±Ð»ÑÐµÐ¼/Ñ€Ð°ÑÑˆÐ¸Ñ€ÑÐµÐ¼
        sphereColor =
            const Color(0xFFE0F2F1); // Ð¥Ð¾Ð»Ð¾Ð´Ð½Ñ‹Ð¹ Ñ†Ð²ÐµÑ‚ Ð¾Ñ‚Ð´Ñ‹Ñ…Ð°
        showTimer = true;
        break;
      case KegelPhase.paused:
        title = l10n.kegelPaused;
        subtitle = "Tap play to resume"; // TODO: l10n
        sphereScale = 1.0;
        sphereColor = Colors.grey.withValues(alpha: 0.2);
        showTimer = true;
        break;
      case KegelPhase.finished:
        title = l10n.kegelPhaseDone;
        subtitle = l10n.kegelPhaseDoneInstr;
        sphereScale = 1.0;
        sphereColor = primaryColor;
        break;
    }

    // ÐžÐ±Ñ‰Ð¸Ð¹ Ð¿Ñ€Ð¾Ð³Ñ€ÐµÑÑ (0.0 -> 1.0)
    double progress = 0;
    if (_phase != KegelPhase.idle && _phase != KegelPhase.finished) {
      // Ð“Ñ€ÑƒÐ±Ñ‹Ð¹ Ñ€Ð°ÑÑ‡ÐµÑ‚ Ð¿Ñ€Ð¾Ð³Ñ€ÐµÑÑÐ°
      int totalSeconds = (_squeezeDuration + _relaxDuration) * _totalReps;
      int completedReps = _currentRep - 1;
      int currentStepSeconds = 0;
      if (_phase == KegelPhase.squeeze ||
          (_phase == KegelPhase.paused &&
              _previousPhase == KegelPhase.squeeze)) {
        currentStepSeconds = (_squeezeDuration - _timeLeft);
      } else {
        currentStepSeconds = _squeezeDuration + (_relaxDuration - _timeLeft);
      }

      int elapsedTotal = (completedReps * (_squeezeDuration + _relaxDuration)) +
          currentStepSeconds;
      progress = (elapsedTotal / totalSeconds).clamp(0.0, 1.0);
    } else if (_phase == KegelPhase.finished) {
      progress = 1.0;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: mutedColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2))),

          // Header: ÐšÐ½Ð¾Ð¿ÐºÐ° Ð½Ð°ÑÑ‚Ñ€Ð¾ÐµÐº
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: (_phase == KegelPhase.idle ||
                        _phase == KegelPhase.finished)
                    ? () => _showSettings(context)
                    : null, // ÐÐµÐ»ÑŒÐ·Ñ Ð¼ÐµÐ½ÑÑ‚ÑŒ Ð½Ð°ÑÑ‚Ñ€Ð¾Ð¹ÐºÐ¸ Ð²Ð¾ Ð²Ñ€ÐµÐ¼Ñ Ñ‚Ñ€ÐµÐ½Ð¸Ñ€Ð¾Ð²ÐºÐ¸
                icon: Icon(Icons.tune,
                    color: (_phase == KegelPhase.idle ||
                            _phase == KegelPhase.finished)
                        ? mainTextColor
                        : mutedColor.withValues(alpha: 0.3)),
              ),
            ),
          ),

          // Ð—ÐÐ“ÐžÐ›ÐžÐ’ÐšÐ˜
          SizedBox(
            height: 100,
            child: AnimatedSwitcher(
              duration: 300.ms,
              child: Column(
                key: ValueKey(_phase),
                children: [
                  Text(
                    title,
                    style: theme.textTheme.displayLarge?.copyWith(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(subtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: mutedColor)),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Ð’Ð˜Ð—Ð£ÐÐ›Ð¬ÐÐ«Ð™ Ð¢Ð Ð•ÐÐÐ–Ð•Ð
          Stack(
            alignment: Alignment.center,
            children: [
              // 1. ÐŸÑ€Ð¾Ð³Ñ€ÐµÑÑ Ð±Ð°Ñ€ (ÐºÐ¾Ð»ÑŒÑ†Ð¾)
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  backgroundColor: mutedColor.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              ),

              // 2. Ð¤Ð¾Ð½Ð¾Ð²Ñ‹Ðµ Ð¿ÑƒÐ»ÑŒÑÐ¸Ñ€ÑƒÑŽÑ‰Ð¸Ðµ ÐºÑ€ÑƒÐ³Ð¸ (Ñ‚Ð¾Ð»ÑŒÐºÐ¾ Ð¿Ñ€Ð¸ ÑÐ¶Ð°Ñ‚Ð¸Ð¸)
              if (_phase == KegelPhase.squeeze)
                AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 250 -
                            (20 *
                                _pulseController
                                    .value), // Ð›ÐµÐ³ÐºÐ¾Ðµ Ð´Ð²Ð¸Ð¶ÐµÐ½Ð¸Ðµ
                        height: 250 - (20 * _pulseController.value),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: sphereColor.withValues(
                                    alpha: 0.3 * (1 - _pulseController.value)),
                                width: 20 * _pulseController.value)),
                      );
                    }),

              // 3. ÐÐšÐ¢Ð˜Ð’ÐÐÐ¯ Ð¡Ð¤Ð•Ð Ð (Ð¯Ð´Ñ€Ð¾)
              AnimatedContainer(
                duration: 800.ms,
                curve: Curves.elasticOut,
                width: 250 * sphereScale,
                height: 250 * sphereScale,
                decoration: BoxDecoration(
                    color: sphereColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: sphereColor.withValues(alpha: 0.6),
                          blurRadius: _phase == KegelPhase.squeeze ? 40 : 20,
                          spreadRadius: _phase == KegelPhase.squeeze ? 10 : 0)
                    ]),
                child: Center(
                  child: showTimer
                      ? Text(
                          "$_timeLeft",
                          style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: mainTextColor.withValues(alpha: 0.8)),
                        )
                      : (_phase == KegelPhase.finished
                          ? const Icon(Icons.check,
                              size: 64, color: Colors.white)
                          : Icon(Icons.play_arrow_rounded,
                              size: 64,
                              color: mainTextColor.withValues(alpha: 0.3))),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Ð˜ÐÐ”Ð˜ÐšÐÐ¢ÐžÐ  ÐŸÐžÐ”Ð¥ÐžÐ”ÐžÐ’
          Text(
              (_phase == KegelPhase.idle)
                  ? '$_totalReps Reps  |  $_squeezeDuration s / $_relaxDuration s'
                  : l10n.kegelRepCounter(_currentRep, _totalReps),
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: mutedColor, fontWeight: FontWeight.bold)),

          const SizedBox(height: 24),

          // ÐŸÐÐÐ•Ð›Ð¬ Ð£ÐŸÐ ÐÐ’Ð›Ð•ÐÐ˜Ð¯
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // ÐšÐÐžÐŸÐšÐ Ð¡Ð‘Ð ÐžÐ¡ (ÐµÑÐ»Ð¸ Ð¿Ð°ÑƒÐ·Ð°)
                if (_phase == KegelPhase.paused ||
                    _phase == KegelPhase.finished)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: OutlinedButton(
                        onPressed: _reset,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(
                              color: mutedColor.withValues(alpha: 0.3)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        child: Text(l10n.nameReset), // "Reset"
                      ),
                    ),
                  ),

                // Ð“Ð›ÐÐ’ÐÐÐ¯ ÐšÐÐžÐŸÐšÐ (Ð¡Ñ‚Ð°Ñ€Ñ‚ / ÐŸÐ°ÑƒÐ·Ð° / Ð¤Ð¸Ð½Ð¸Ñˆ)
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _phase == KegelPhase.finished
                        ? () => Navigator.pop(context)
                        : (_phase == KegelPhase.idle
                            ? _startTraining
                            : _togglePause),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    icon: Icon(
                        _phase == KegelPhase.idle || _phase == KegelPhase.paused
                            ? Icons.play_arrow
                            : (_phase == KegelPhase.finished
                                ? Icons.check
                                : Icons.pause)),
                    label: Text(
                      _phase == KegelPhase.idle
                          ? l10n.kegelStart
                          : (_phase == KegelPhase.paused
                              ? l10n.kegelStart
                              : (_phase == KegelPhase.finished
                                  ? l10n.kegelFinish
                                  : l10n.kegelPaused)),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
