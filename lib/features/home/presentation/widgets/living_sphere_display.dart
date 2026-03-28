import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/glass_sphere.dart';
import '../../../../core/ui/optimized_image.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../pregnancy/data/fetal_growth_mapper.dart';
import '../../../pregnancy/domain/fetal_growth_stage.dart';
import '../../../pregnancy/data/pregnancy_repository.dart';
import '../../../pregnancy/domain/pregnancy_settings.dart';

final pregnancySettingsStreamProvider =
    StreamProvider<PregnancySettings?>((ref) {
  final repository = ref.watch(pregnancyRepositoryProvider);
  return repository.watchSettings();
});

class LivingSphereDisplay extends ConsumerStatefulWidget {
  final int week;
  final double scale;

  const LivingSphereDisplay({
    super.key,
    required this.week,
    this.scale = 1.0,
  });

  @override
  ConsumerState<LivingSphereDisplay> createState() =>
      _LivingSphereDisplayState();
}

class _LivingSphereDisplayState extends ConsumerState<LivingSphereDisplay> {
  static const List<String> _modeOrder = [
    PregnancySettings.visualModeFruit,
    PregnancySettings.visualModeRealistic,
    PregnancySettings.visualModeGrowth,
  ];

  bool _isSavingMode = false;
  int _weekTransitionDirection = 1;

  @override
  void didUpdateWidget(covariant LivingSphereDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.week == oldWidget.week) {
      return;
    }

    _weekTransitionDirection = widget.week >= oldWidget.week ? 1 : -1;
  }

  void _showErrorSnack(String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _toggleMode(String currentMode) async {
    if (_isSavingMode) {
      return;
    }

    final currentIndex = _modeOrder.indexOf(currentMode);
    final nextMode = _modeOrder[
        (currentIndex == -1 ? 0 : currentIndex + 1) % _modeOrder.length];

    setState(() {
      _isSavingMode = true;
    });

    try {
      await ref.read(pregnancyRepositoryProvider).setVisualMode(nextMode);
    } catch (_) {
      if (mounted) {
        _showErrorSnack(
          AppLocalizations.of(context)?.errorGeneric ??
              "Something went wrong. Please try again.",
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSavingMode = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsAsync = ref.watch(pregnancySettingsStreamProvider);
    final visualModeKey = settingsAsync.value?.effectiveVisualModeKey ??
        PregnancySettings.visualModeFruit;

    final int safeWeek = widget.week.clamp(1, 42);
    int imageWeek = safeWeek;
    if (safeWeek < 4) imageWeek = 4;
    if (safeWeek > 40) imageWeek = 40;

    final growthData = FetalGrowthMapper.forWeek(safeWeek.clamp(1, 40));
    final isGrowthMode = visualModeKey == PregnancySettings.visualModeGrowth;
    final imagePath = switch (visualModeKey) {
      PregnancySettings.visualModeFruit =>
        'assets/images/fruits/week_$imageWeek.webp',
      PregnancySettings.visualModeGrowth => growthData.assetPath,
      _ => 'assets/images/realistic/week_$imageWeek.webp',
    };
    final biometrics = _PregnancyData.getForWeek(safeWeek, l10n);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final double contentSize = math.min(availableWidth, 400.0);
        final double orbitSize = contentSize * 0.9;
        final double sphereSize = contentSize * 0.82;

        return RepaintBoundary(
          child: Transform.scale(
            scale: widget.scale,
            child: Center(
              child: SizedBox(
                width: contentSize,
                height: contentSize,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: orbitSize,
                      height: orbitSize,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: safeWeek / 40.0),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return CustomPaint(
                            size: Size(orbitSize, orbitSize),
                            painter: OrbitPainter(
                              progress: value,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: sphereSize,
                      height: sphereSize,
                      child: Center(
                        child: GlassSphere(
                          size: sphereSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Transform.scale(
                                scale: sphereSize / 340,
                                child: const MagicalLifeCore(),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 600),
                                switchInCurve: Curves.easeOutBack,
                                switchOutCurve: Curves.easeIn,
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ScaleTransition(
                                      scale: animation.drive(
                                        Tween(begin: 0.9, end: 1.0),
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Transform.translate(
                                  key: ValueKey<String>(
                                    '$visualModeKey-$imageWeek-${safeWeek.clamp(1, 40)}',
                                  ),
                                  offset: Offset(0, isGrowthMode ? 4 : 0),
                                  child: isGrowthMode
                                      ? _GrowthSphereImage(
                                          sphereSize: sphereSize,
                                          imagePath: imagePath,
                                          growthData: growthData,
                                          week: safeWeek.clamp(1, 40),
                                          transitionDirection:
                                              _weekTransitionDirection,
                                        )
                                      : OptimizedImage(
                                          path: imagePath,
                                          height: sphereSize * 0.6,
                                          memCacheWidth: 800,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 0.85),
                      child: _ModeToggleButton(
                        visualModeKey: visualModeKey,
                        isSaving: _isSavingMode,
                        onTap: () => _toggleMode(visualModeKey),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(-0.9, -0.5),
                      child: _BiometricTag(
                        label: l10n.labelLength,
                        value: biometrics.length,
                        alignment: CrossAxisAlignment.start,
                        delay: 200,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.9, 0.5),
                      child: _BiometricTag(
                        label: l10n.labelWeight,
                        value: biometrics.weight,
                        alignment: CrossAxisAlignment.end,
                        delay: 400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ModeToggleButton extends StatelessWidget {
  final String visualModeKey;
  final bool isSaving;
  final VoidCallback onTap;

  const _ModeToggleButton({
    required this.visualModeKey,
    required this.isSaving,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final isRu = locale == 'ru';

    final (IconData icon, String label, int target) = switch (visualModeKey) {
      PregnancySettings.visualModeFruit => (
          Icons.eco_rounded,
          l10n.visualModeFruit,
          0,
        ),
      PregnancySettings.visualModeGrowth => (
          Icons.child_friendly_rounded,
          isRu ? 'Развитие' : 'Growth',
          2,
        ),
      _ => (
          Icons.widgets_rounded,
          l10n.visualModeRealistic,
          1,
        ),
    };

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSaving ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSaving)
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              else
                Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 8),
              Text(
                isSaving ? l10n.commonSave : label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: target.toDouble()).scale(
          duration: 300.ms,
          curve: Curves.easeOutBack,
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
        );
  }
}

class _GrowthSphereImage extends StatelessWidget {
  final double sphereSize;
  final String imagePath;
  final FetalGrowthPresentation growthData;
  final int week;
  final int transitionDirection;

  const _GrowthSphereImage({
    required this.sphereSize,
    required this.imagePath,
    required this.growthData,
    required this.week,
    required this.transitionDirection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewportSize = sphereSize * 0.62;
    final normalizedScale =
        0.88 + ((growthData.scale - 0.74) / 1.08).clamp(0.0, 1.0) * 0.36;
    final normalizedOffset = (growthData.yOffset / 14).clamp(-1.0, 1.0) * -8;
    final glowOpacity = 0.12 + growthData.overallProgress * 0.16;
    final rotation = -0.05 + growthData.weekProgress * 0.1;
    final direction = transitionDirection.toDouble();

    return SizedBox(
      width: viewportSize,
      height: viewportSize,
      child: ClipOval(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.15),
              radius: 0.92,
              colors: [
                theme.primaryColor.withValues(alpha: 0.08),
                theme.primaryColor.withValues(alpha: 0.02),
                Colors.transparent,
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                key: ValueKey<String>(
                  'growth_sphere_transition_${week}_$imagePath',
                ),
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 820),
                curve: Curves.easeOutCubic,
                builder: (context, t, child) {
                  final imageSlideX = (1 - t) * 18 * direction;
                  final imageSlideY = normalizedOffset + (1 - t) * 10;
                  final glowSlideX = (1 - t) * -12 * direction;
                  final animatedScale = normalizedScale * (0.88 + (t * 0.12));
                  final animatedRotation =
                      rotation + ((1 - t) * -0.08 * direction);
                  final animatedGlowSize =
                      viewportSize * (0.68 + growthData.overallProgress * 0.24);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(glowSlideX, 0),
                        child: Opacity(
                          opacity: 0.4 + (t * 0.6),
                          child: Container(
                            width: animatedGlowSize,
                            height: animatedGlowSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFD6DE)
                                      .withValues(alpha: glowOpacity),
                                  blurRadius:
                                      28 + growthData.overallProgress * 18,
                                  spreadRadius:
                                      8 + growthData.overallProgress * 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(imageSlideX, imageSlideY),
                        child: Opacity(
                          opacity: 0.2 + (t * 0.8),
                          child: Transform.rotate(
                            angle: animatedRotation,
                            child: Transform.scale(
                              scale: animatedScale,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: OptimizedImage(
                  path: imagePath,
                  width: viewportSize,
                  height: viewportSize,
                  fit: BoxFit.contain,
                  memCacheWidth: 900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BreathingBackground extends StatefulWidget {
  const BreathingBackground({super.key});

  @override
  State<BreathingBackground> createState() => _BreathingBackgroundState();
}

class _BreathingBackgroundState extends State<BreathingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.15),
                  primaryColor.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.7],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BiometricTag extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment alignment;
  final int delay;

  const _BiometricTag({
    required this.label,
    required this.value,
    required this.alignment,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.5,
            color: mutedColor.withValues(alpha: 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: mainColor.withValues(alpha: 0.8),
            fontFamily: "Serif",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: delay.ms)
        .moveY(begin: 10, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

class OrbitPainter extends CustomPainter {
  final double progress;
  final Color color;

  OrbitPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final trackPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, trackPaint);

    final activePaint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      activePaint,
    );

    if (progress > 0) {
      final endAngle = startAngle + sweepAngle;
      final endPoint = Offset(
        center.dx + radius * math.cos(endAngle),
        center.dy + radius * math.sin(endAngle),
      );
      canvas.drawCircle(
        endPoint,
        6.0,
        Paint()
          ..color = color.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
      canvas.drawCircle(endPoint, 3.0, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant OrbitPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class MagicalLifeCore extends StatefulWidget {
  const MagicalLifeCore({super.key});

  @override
  State<MagicalLifeCore> createState() => _MagicalLifeCoreState();
}

class _MagicalLifeCoreState extends State<MagicalLifeCore>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
    final curve =
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine);
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(curve);
    _opacityAnimation = Tween<double>(begin: 0.5, end: 0.8).animate(curve);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFCE38A).withValues(alpha: 0.6),
                    const Color(0xFF8E9BAE).withValues(alpha: 0.0),
                  ],
                  stops: const [0.2, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFCE38A).withValues(alpha: 0.3),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PregnancyData {
  final String weight;
  final String length;

  _PregnancyData(this.weight, this.length);

  static _PregnancyData getForWeek(int week, AppLocalizations l10n) {
    final safeWeek = week.clamp(1, 42);
    final raw =
        _biometricsMap[safeWeek] ?? (safeWeek < 4 ? [0, 0] : [3500, 510]);

    final double weightG = raw[0].toDouble();
    final double lengthMm = raw[1].toDouble();

    String wStr;
    if (weightG <= 0) {
      wStr = l10n.valLessThanOneGram;
    } else if (weightG >= 1000) {
      final kg = (weightG / 1000).toStringAsFixed(1).replaceAll('.0', '');
      wStr = l10n.valKg(kg);
    } else {
      wStr = l10n.valGram(weightG.toInt().toString());
    }

    String lStr;
    if (lengthMm <= 0) {
      lStr = l10n.valLessThanOneMm;
    } else if (lengthMm >= 10) {
      final cm = (lengthMm / 10).toStringAsFixed(1).replaceAll('.0', '');
      lStr = l10n.valCm(cm);
    } else {
      lStr = l10n.valMm(lengthMm.toInt().toString());
    }

    return _PregnancyData(wStr, lStr);
  }

  static const Map<int, List<num>> _biometricsMap = {
    1: [0, 0],
    2: [0, 0],
    3: [0, 0],
    4: [0, 2],
    5: [0, 3],
    6: [0, 5],
    7: [0, 13],
    8: [1, 16],
    9: [2, 23],
    10: [4, 31],
    11: [7, 41],
    12: [14, 54],
    13: [23, 74],
    14: [43, 87],
    15: [70, 101],
    16: [100, 116],
    17: [140, 130],
    18: [190, 142],
    19: [240, 153],
    20: [300, 256],
    21: [360, 267],
    22: [430, 278],
    23: [500, 289],
    24: [600, 300],
    25: [660, 346],
    26: [760, 356],
    27: [875, 366],
    28: [1000, 376],
    29: [1200, 386],
    30: [1300, 399],
    31: [1500, 411],
    32: [1700, 424],
    33: [1900, 437],
    34: [2100, 450],
    35: [2400, 462],
    36: [2600, 474],
    37: [2900, 486],
    38: [3100, 498],
    39: [3300, 507],
    40: [3500, 512],
    41: [3700, 517],
    42: [3900, 520],
  };
}
