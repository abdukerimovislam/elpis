import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui'; // Для FontFeature

// ИМПОРТ ЛОКАЛИЗАЦИИ
import '../../../l10n/app_localizations.dart';

// ИМПОРТЫ ДАННЫХ
import '../../health/data/contraction_timer_provider.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../health/domain/contraction.dart';

class LaborContractionTimer extends ConsumerStatefulWidget {
  const LaborContractionTimer({super.key});

  @override
  ConsumerState<LaborContractionTimer> createState() => _LaborContractionTimerState();
}

class _LaborContractionTimerState extends ConsumerState<LaborContractionTimer> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // Анимация дыхания (2 сек вдох, 2 сек выдох)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // 1. Получаем состояние таймера (секунды, активен ли)
    final timerState = ref.watch(contractionTimerProvider);
    final isRunning = timerState.isActive;

    // 2. Получаем поток истории схваток
    final contractionsStream = ref.watch(pregnancyRepositoryProvider).watchContractions();

    // Логика анимации
    if (isRunning && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!isRunning && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }

    // Цвета
    final activeColor = const Color(0xFFFF9A9E);
    final restColor = const Color(0xFFa1c4fd);
    final currentColor = isRunning ? activeColor : restColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- ЗАГОЛОВОК ---
        Text(
          isRunning ? l10n.laborTimerContraction : l10n.laborTimerResting,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: currentColor,
          ),
        ),
        const SizedBox(height: 8),

        // --- ЦИФРЫ ТАЙМЕРА ---
        Text(
          _formatDuration(timerState.duration),
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w200,
            fontFeatures: [FontFeature.tabularFigures()],
            color: Color(0xFF2D3142),
          ),
        ),

        const Spacer(),

        // --- ДЫШАЩАЯ КНОПКА (THE ZEN BUTTON) ---
        GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            // Вызываем метод переключения таймера
            ref.read(contractionTimerProvider.notifier).toggleTimer();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Аура (только при активности)
              if (isRunning)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_pulseController.value * 0.3),
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeColor.withOpacity(0.2 - (_pulseController.value * 0.15)),
                        ),
                      ),
                    );
                  },
                ),

              // Сама кнопка
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isRunning
                        ? [const Color(0xFFFF9A9E), const Color(0xFFFECFEF)]
                        : [const Color(0xFFa1c4fd), const Color(0xFFc2e9fb)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: currentColor.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      offset: Offset(-5, -5),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isRunning ? l10n.laborTimerBreathe : l10n.laborTimerStart,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // --- ИСТОРИЯ (STREAM BUILDER) ---
        StreamBuilder<List<Contraction>>(
          stream: contractionsStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SizedBox(height: 60, child: Center(child: Text(l10n.laborTimerReady)));
            }

            final history = snapshot.data!;
            // Ищем последнюю ЗАВЕРШЕННУЮ схватку
            final lastCompleted = history.where((c) => c.endTime != null).firstOrNull;

            if (lastCompleted == null) {
              return SizedBox(height: 60, child: Center(child: Text(l10n.laborTimerMonitoring)));
            }

            // Длительность последней схватки
            final duration = lastCompleted.endTime!.difference(lastCompleted.startTime);

            // Расчет частоты (если есть хотя бы 2 схватки)
            String freqText = "--";
            if (history.length >= 2) {
              final lastStart = history[0].startTime;
              final prevStart = history[1].startTime;
              final diff = lastStart.difference(prevStart);
              freqText = "${diff.inMinutes} ${l10n.commonMinutes}"; // Добавил локализацию мин
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatItem(l10n.laborTimerLastDuration, "${duration.inSeconds} ${l10n.commonSeconds}"),
                  Container(height: 30, width: 1, color: Colors.grey[300], margin: const EdgeInsets.symmetric(horizontal: 20)),
                  _buildStatItem(l10n.laborTimerFrequency, freqText),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2D3142))),
      ],
    );
  }
}