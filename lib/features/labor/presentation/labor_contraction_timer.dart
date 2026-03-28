import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../health/data/contraction_timer_provider.dart';
import '../../health/domain/contraction.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

class LaborContractionTimer extends ConsumerStatefulWidget {
  const LaborContractionTimer({super.key});

  @override
  ConsumerState<LaborContractionTimer> createState() =>
      _LaborContractionTimerState();
}

class _LaborContractionTimerState extends ConsumerState<LaborContractionTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
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

  String _formatDuration(Duration duration) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timerState = ref.watch(contractionTimerProvider);
    final isRunning = timerState.isActive;
    final contractionsStream =
        ref.watch(pregnancyRepositoryProvider).watchContractions();

    if (isRunning && !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (!isRunning && _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }

    const activeColor = Color(0xFFFF9A9E);
    const restColor = Color(0xFFa1c4fd);
    final currentColor = isRunning ? activeColor : restColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        GestureDetector(
          onTap: timerState.isProcessing
              ? null
              : () async {
                  HapticFeedback.heavyImpact();
                  try {
                    await ref
                        .read(contractionTimerProvider.notifier)
                        .toggleTimer();
                  } catch (_) {
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.errorGeneric)),
                    );
                  }
                },
          child: Stack(
            alignment: Alignment.center,
            children: [
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
                          color: activeColor.withValues(
                            alpha: 0.2 - (_pulseController.value * 0.15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                      color: currentColor.withValues(alpha: 0.4),
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
                      if (timerState.isProcessing)
                        const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      else
                        Icon(
                          isRunning
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        timerState.isProcessing
                            ? l10n.commonSave
                            : isRunning
                                ? l10n.laborTimerBreathe
                                : l10n.laborTimerStart,
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
        StreamBuilder<List<Contraction>>(
          stream: contractionsStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SizedBox(
                height: 60,
                child: Center(child: Text(l10n.laborTimerReady)),
              );
            }

            final history = snapshot.data!;
            final lastCompleted = history
                .where((contraction) => contraction.endTime != null)
                .firstOrNull;

            if (lastCompleted == null) {
              return SizedBox(
                height: 60,
                child: Center(child: Text(l10n.laborTimerMonitoring)),
              );
            }

            final duration =
                lastCompleted.endTime!.difference(lastCompleted.startTime);

            String frequencyText = '--';
            if (history.length >= 2) {
              final lastStart = history[0].startTime;
              final previousStart = history[1].startTime;
              final difference = lastStart.difference(previousStart);
              frequencyText = '${difference.inMinutes} ${l10n.commonMinutes}';
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatItem(
                    l10n.laborTimerLastDuration,
                    '${duration.inSeconds} ${l10n.commonSeconds}',
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  _buildStatItem(l10n.laborTimerFrequency, frequencyText),
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
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }
}
