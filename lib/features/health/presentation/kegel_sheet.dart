import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wakelock_plus/wakelock_plus.dart'; // Не забываем про Wakelock
import '../../../l10n/app_localizations.dart';

enum KegelPhase { idle, squeeze, relax, finished, paused }

class KegelSheet extends StatefulWidget {
  const KegelSheet({super.key});

  @override
  State<KegelSheet> createState() => _KegelSheetState();
}

class _KegelSheetState extends State<KegelSheet> with SingleTickerProviderStateMixin {
  // Настройки (по умолчанию)
  int _squeezeDuration = 5;
  int _relaxDuration = 5;
  int _totalReps = 10;

  // Состояние
  KegelPhase _phase = KegelPhase.idle;
  KegelPhase _previousPhase = KegelPhase.idle; // Чтобы вернуться после паузы
  int _timeLeft = 0;
  int _currentRep = 1;
  Timer? _timer;

  // Для анимации прогресса
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  // --- ЛОГИКА ТАЙМЕРА ---

  void _startTraining() {
    setState(() {
      _currentRep = 1;
      _startPhase(KegelPhase.squeeze);
    });
  }

  void _togglePause() {
    if (_phase == KegelPhase.finished || _phase == KegelPhase.idle) return;

    if (_phase == KegelPhase.paused) {
      // Возобновляем
      _resumeTimer();
    } else {
      // Ставим на паузу
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
    // Запускаем таймер с оставшегося времени
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
        _pulseController.repeat(reverse: true); // Пульсация при напряжении
      } else if (_phase == KegelPhase.relax) {
        _timeLeft = _relaxDuration;
        HapticFeedback.lightImpact();
        _pulseController.stop();
        _pulseController.value = 0.0; // Сброс анимации
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
      // После сжатия -> отдых
      _startPhase(KegelPhase.relax);
    } else if (_phase == KegelPhase.relax) {
      // После отдыха -> либо новое сжатие, либо конец
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
    // Можно сохранить результат в базу данных здесь
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _phase = KegelPhase.idle;
      _currentRep = 1;
      _timeLeft = 0;
    });
  }

  // --- НАСТРОЙКИ ---
  void _showSettings(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Временные переменные
    int tempSqueeze = _squeezeDuration;
    int tempRelax = _relaxDuration;
    int tempReps = _totalReps;

    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (context, setModalState) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.kegelSettingsTitle, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 24),

                      _buildSlider(context, l10n.kegelSettingWork, tempSqueeze, 1, 15, (val) => setModalState(() => tempSqueeze = val)),
                      _buildSlider(context, l10n.kegelSettingRest, tempRelax, 1, 15, (val) => setModalState(() => tempRelax = val)),
                      _buildSlider(context, l10n.kegelSettingReps, tempReps, 5, 50, (val) => setModalState(() => tempReps = val)),

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
              }
          );
        }
    );
  }

  Widget _buildSlider(BuildContext context, String title, int value, double min, double max, Function(int) onChanged) {
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

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;

    // Параметры UI
    String title;
    String subtitle;
    double sphereScale; // 1.0 = норма, 0.7 = сжатие
    Color sphereColor;
    bool showTimer = false;

    switch (_phase) {
      case KegelPhase.idle:
        title = l10n.kegelTitle;
        subtitle = l10n.kegelSubtitle;
        sphereScale = 1.0;
        sphereColor = primaryColor.withOpacity(0.1);
        break;
      case KegelPhase.squeeze:
        title = l10n.kegelPhaseSqueeze;
        subtitle = l10n.kegelPhaseSqueezeInstr;
        sphereScale = 0.65; // Визуально сжимаем
        sphereColor = const Color(0xFFFFCCBC); // Теплый цвет напряжения
        showTimer = true;
        break;
      case KegelPhase.relax:
        title = l10n.kegelPhaseRelax;
        subtitle = l10n.kegelPhaseRelaxInstr;
        sphereScale = 1.1; // Расслабляем/расширяем
        sphereColor = const Color(0xFFE0F2F1); // Холодный цвет отдыха
        showTimer = true;
        break;
      case KegelPhase.paused:
        title = l10n.kegelPaused;
        subtitle = "Tap play to resume"; // TODO: l10n
        sphereScale = 1.0;
        sphereColor = Colors.grey.withOpacity(0.2);
        showTimer = true;
        break;
      case KegelPhase.finished:
        title = l10n.kegelPhaseDone;
        subtitle = l10n.kegelPhaseDoneInstr;
        sphereScale = 1.0;
        sphereColor = primaryColor;
        break;
    }

    // Общий прогресс (0.0 -> 1.0)
    double progress = 0;
    if (_phase != KegelPhase.idle && _phase != KegelPhase.finished) {
      // Грубый расчет прогресса
      int totalSeconds = (_squeezeDuration + _relaxDuration) * _totalReps;
      int completedReps = _currentRep - 1;
      int currentStepSeconds = 0;
      if (_phase == KegelPhase.squeeze || (_phase == KegelPhase.paused && _previousPhase == KegelPhase.squeeze)) {
        currentStepSeconds = (_squeezeDuration - _timeLeft);
      } else {
        currentStepSeconds = _squeezeDuration + (_relaxDuration - _timeLeft);
      }

      int elapsedTotal = (completedReps * (_squeezeDuration + _relaxDuration)) + currentStepSeconds;
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
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: mutedColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2)
              )
          ),

          // Header: Кнопка настроек
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: (_phase == KegelPhase.idle || _phase == KegelPhase.finished)
                    ? () => _showSettings(context)
                    : null, // Нельзя менять настройки во время тренировки
                icon: Icon(Icons.tune, color: (_phase == KegelPhase.idle || _phase == KegelPhase.finished) ? mainTextColor : mutedColor.withOpacity(0.3)),
              ),
            ),
          ),

          // ЗАГОЛОВКИ
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
                    child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor)
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // ВИЗУАЛЬНЫЙ ТРЕНАЖЕР
          Stack(
            alignment: Alignment.center,
            children: [
              // 1. Прогресс бар (кольцо)
              SizedBox(
                width: 300, height: 300,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  backgroundColor: mutedColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              ),

              // 2. Фоновые пульсирующие круги (только при сжатии)
              if (_phase == KegelPhase.squeeze)
                AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 250 - (20 * _pulseController.value), // Легкое движение
                        height: 250 - (20 * _pulseController.value),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: sphereColor.withOpacity(0.3 * (1 - _pulseController.value)),
                                width: 20 * _pulseController.value
                            )
                        ),
                      );
                    }
                ),

              // 3. АКТИВНАЯ СФЕРА (Ядро)
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
                          color: sphereColor.withOpacity(0.6),
                          blurRadius: _phase == KegelPhase.squeeze ? 40 : 20,
                          spreadRadius: _phase == KegelPhase.squeeze ? 10 : 0
                      )
                    ]
                ),
                child: Center(
                  child: showTimer
                      ? Text(
                    "$_timeLeft",
                    style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: mainTextColor.withOpacity(0.8)
                    ),
                  )
                      : (_phase == KegelPhase.finished
                      ? Icon(Icons.check, size: 64, color: Colors.white)
                      : Icon(Icons.play_arrow_rounded, size: 64, color: mainTextColor.withOpacity(0.3))),
                ),
              ),
            ],
          ),

          const Spacer(),

          // ИНДИКАТОР ПОДХОДОВ
          Text(
              (_phase == KegelPhase.idle)
                  ? "${_totalReps} Reps  •  ${_squeezeDuration}s / ${_relaxDuration}s"
                  : l10n.kegelRepCounter(_currentRep, _totalReps),
              style: theme.textTheme.labelLarge?.copyWith(color: mutedColor, fontWeight: FontWeight.bold)
          ),

          const SizedBox(height: 24),

          // ПАНЕЛЬ УПРАВЛЕНИЯ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // КНОПКА СБРОС (если пауза)
                if (_phase == KegelPhase.paused || _phase == KegelPhase.finished)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: OutlinedButton(
                        onPressed: _reset,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: mutedColor.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                        child: Text(l10n.nameReset), // "Reset"
                      ),
                    ),
                  ),

                // ГЛАВНАЯ КНОПКА (Старт / Пауза / Финиш)
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _phase == KegelPhase.finished
                        ? () => Navigator.pop(context)
                        : (_phase == KegelPhase.idle ? _startTraining : _togglePause),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    icon: Icon(
                        _phase == KegelPhase.idle || _phase == KegelPhase.paused ? Icons.play_arrow : (_phase == KegelPhase.finished ? Icons.check : Icons.pause)
                    ),
                    label: Text(
                      _phase == KegelPhase.idle
                          ? l10n.kegelStart
                          : (_phase == KegelPhase.paused ? l10n.kegelStart : (_phase == KegelPhase.finished ? l10n.kegelFinish : l10n.kegelPaused)),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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