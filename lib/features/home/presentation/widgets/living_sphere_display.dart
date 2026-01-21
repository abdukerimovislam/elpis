import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/glass_sphere.dart';
import '../../../../l10n/app_localizations.dart';

// Импорты репозитория и настроек
import 'package:bloom_mama/features/pregnancy/data/pregnancy_repository.dart';
import 'package:bloom_mama/features/pregnancy/domain/pregnancy_settings.dart';

// Провайдер стрима настроек
final pregnancySettingsStreamProvider = StreamProvider<PregnancySettings?>((ref) {
  final repository = ref.watch(pregnancyRepositoryProvider);
  return repository.watchSettings();
});

class LivingSphereDisplay extends ConsumerWidget {
  final int week;
  final double scale;
  final double blur;

  const LivingSphereDisplay({
    super.key,
    required this.week,
    this.scale = 1.0,
    this.blur = 0.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // ПОЛУЧАЕМ ТЕМУ
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    // 1. СЛУШАЕМ НАСТРОЙКИ
    final settingsAsync = ref.watch(pregnancySettingsStreamProvider);
    final bool isFruitMode = settingsAsync.value?.isFruitMode ?? true;

    final int safeWeek = week.clamp(1, 42);

    // ИСПРАВЛЕНИЕ: Пути соответствуют новым папкам assets/images/fruits и assets/images/realistic
    final folderName = isFruitMode ? 'fruits' : 'realistic';
    final imagePath = 'assets/images/$folderName/week_$safeWeek.webp';

    final fallbackIcon = isFruitMode ? Icons.eco : Icons.widgets;

    final biometrics = _PregnancyData.getForWeek(safeWeek, l10n);

    // 2. ДЕЙСТВИЕ
    void toggleMode() {
      final repo = ref.read(pregnancyRepositoryProvider);
      repo.setFruitMode(!isFruitMode);
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          final double contentSize = math.min(availableWidth, 400.0);

          final double orbitSize = contentSize * 0.9;
          final double sphereSize = contentSize * 0.82;
          final double backgroundSize = contentSize * 0.95;

          // ИЗОЛЯЦИЯ ПЕРЕРИСОВКИ: Критично для производительности
          return RepaintBoundary(
            child: Transform.scale(
              scale: scale,
              child: ImageFiltered(
                // БЛЮР: Если он > 0, это может тормозить.
                // В идеале GlassCard должен управлять этим, но тут мы блюрим весь виджет при скролле.
                imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Center(
                  child: SizedBox(
                    width: contentSize,
                    height: contentSize,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [

                        // --- 1. ФОН ---
                        SizedBox(
                          width: backgroundSize,
                          height: backgroundSize,
                          child: const Center(child: BreathingBackground()),
                        ),

                        // --- 2. ОРБИТА ---
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
                                  // Используем динамический цвет
                                  color: primaryColor,
                                ),
                              );
                            },
                          ),
                        ),

                        // --- 3. СФЕРА ---
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
                                      child: const MagicalLifeCore()
                                  ),

                                  // Картинка с анимацией
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 600),
                                    switchInCurve: Curves.easeOutBack,
                                    switchOutCurve: Curves.easeIn,
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: ScaleTransition(
                                          scale: animation.drive(Tween(begin: 0.9, end: 1.0)),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      imagePath,
                                      key: ValueKey<String>("$safeWeek$isFruitMode"),
                                      height: sphereSize * 0.6,
                                      fit: BoxFit.contain,
                                      // ОПТИМИЗАЦИЯ: Декодируем уменьшенную копию в память
                                      cacheWidth: 600,
                                      gaplessPlayback: true,
                                      errorBuilder: (_, __, ___) => Icon(
                                          fallbackIcon,
                                          size: sphereSize * 0.3,
                                          color: Colors.white54
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // --- 4. КНОПКА ПЕРЕКЛЮЧЕНИЯ ---
                        Align(
                          alignment: const Alignment(0, 0.85),
                          child: _ModeToggleButton(
                            isFruitMode: isFruitMode,
                            onTap: toggleMode,
                          ),
                        ),

                        // --- 5. ТЕКСТ (Рост) ---
                        Align(
                          alignment: const Alignment(-0.9, -0.5),
                          child: _BiometricTag(
                            label: l10n.labelLength,
                            value: biometrics.length,
                            alignment: CrossAxisAlignment.start,
                            delay: 200,
                          ),
                        ),

                        // --- 6. ТЕКСТ (Вес) ---
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
            ),
          );
        }
    );
  }
}

// --- ВСПОМОГАТЕЛЬНЫЕ КЛАССЫ ---

class _ModeToggleButton extends StatelessWidget {
  final bool isFruitMode;
  final VoidCallback onTap;

  const _ModeToggleButton({
    required this.isFruitMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем цвет текста из темы
    final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black87;
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isFruitMode ? Icons.eco_rounded : Icons.widgets_rounded,
                size: 18,
                color: textColor,
              ),
              const SizedBox(width: 8),
              Text(
                isFruitMode
                    ? (l10n.visualModeFruit.isNotEmpty ? l10n.visualModeFruit : "Fruits")
                    : (l10n.visualModeRealistic.isNotEmpty ? l10n.visualModeRealistic : "Realistic"),
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
    ).animate(target: isFruitMode ? 1 : 0).scale(
        duration: 300.ms,
        curve: Curves.easeOutBack,
        begin: const Offset(0.95, 0.95),
        end: const Offset(1.0, 1.0)
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
    // Используем основной цвет темы для свечения
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
                  primaryColor.withOpacity(0.15),
                  primaryColor.withOpacity(0.0),
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
            color: mutedColor.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: mainColor.withOpacity(0.8),
            fontFamily: "Serif",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ).animate()
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
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, trackPaint);

    final activePaint = Paint()
      ..color = color.withOpacity(0.6)
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
        activePaint
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
          Paint()..color = color.withOpacity(0.3)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      );
      canvas.drawCircle(endPoint, 3.0, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant OrbitPainter oldDelegate) => oldDelegate.progress != progress;
}

class MagicalLifeCore extends StatefulWidget {
  const MagicalLifeCore({super.key});
  @override
  State<MagicalLifeCore> createState() => _MagicalLifeCoreState();
}

class _MagicalLifeCoreState extends State<MagicalLifeCore> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat(reverse: true);
    final curve = CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine);
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
              width: 280, height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  // Цвета ядра оставляем магическими (Золото/Серебро),
                  // они не зависят от темы UI
                  colors: [const Color(0xFFFCE38A).withOpacity(0.6), const Color(0xFF8E9BAE).withOpacity(0.0)],
                  stops: const [0.2, 1.0],
                ),
                boxShadow: [BoxShadow(color: const Color(0xFFFCE38A).withOpacity(0.3), blurRadius: 60, spreadRadius: 10)],
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
    final raw = _biometricsMap[safeWeek] ?? [3500, 510];

    final double weightG = raw[0].toDouble();
    final double lengthMm = raw[1].toDouble();

    String wStr;
    if (weightG <= 0) {
      wStr = l10n.valLessThanOneGram ?? "< 1 g";
    } else if (weightG >= 1000) {
      final kg = (weightG / 1000).toStringAsFixed(1).replaceAll('.0', '');
      wStr = l10n.valKg(kg);
    } else {
      wStr = l10n.valGram(weightG.toInt().toString());
    }

    String lStr;
    if (lengthMm <= 0) {
      lStr = l10n.valLessThanOneMm ?? "< 1 mm";
    } else if (lengthMm >= 10) {
      final cm = (lengthMm / 10).toStringAsFixed(1).replaceAll('.0', '');
      lStr = l10n.valCm(cm);
    } else {
      lStr = l10n.valMm(lengthMm.toInt().toString());
    }

    return _PregnancyData(wStr, lStr);
  }

  static const Map<int, List<num>> _biometricsMap = {
    1:  [0, 0],
    2:  [0, 0],
    3:  [0, 0],
    4:  [0, 2],
    5:  [0, 3],
    6:  [0, 5],
    7:  [0, 13],
    8:  [1, 16],
    9:  [2, 23],
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