import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
// GlassSphere — «Живой жемчуг»
//
// Анимированная стеклянная сфера с тремя улучшениями:
//  А) Переливающийся перламутровый ободок (SweepGradient, вращается)
//  Б) Пульсирующее внешнее свечение (boxShadow меняет цвет)
//  В) Динамический вторичный блик (цвет следует за ободком)
//
// Производительность: один AnimationController, один CustomPaint,
// один drawCircle. Никакого BackdropFilter снаружи.
// ─────────────────────────────────────────────────────────────────
class GlassSphere extends StatefulWidget {
  final double size;
  final Widget child;
  final List<Color>? pearlColors;

  const GlassSphere({
    super.key,
    required this.size,
    required this.child,
    this.pearlColors,
  });

  @override
  State<GlassSphere> createState() => _GlassSphereState();
}

class _GlassSphereState extends State<GlassSphere>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Жемчужная палитра: розовый → лиловый → голубой → персиковый → розовый
  static const List<Color> _pearlColors = [
    Color(0xFFFFB3C6), // нежная роза
    Color(0xFFCDB4FF), // лиловый
    Color(0xFFBDE0FF), // детский голубой
    Color(0xFFFFCFD2), // блаш
    Color(0xFFFFB3C6), // назад к розе (loop)
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Текущий жемчужный цвет по прогрессу t ∈ [0, 1].
  Color _pearlColor(double t) {
    final colors = widget.pearlColors ?? _pearlColors;
    final segments = colors.length - 1;
    final scaled = t * segments;
    final i = scaled.floor().clamp(0, segments - 1);
    return Color.lerp(colors[i], colors[i + 1], scaled - i)!;
  }

  @override
  Widget build(BuildContext context) {
    final double highlightSize  = widget.size * 0.38;
    final double secondarySize  = widget.size * 0.32;

    return AnimatedBuilder(
      animation: _controller,
      // child НЕ перестраивается на каждом кадре — Flutter кешируует его
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        final pearl = _pearlColor(t);
        final pearlSoft = pearl.withValues(alpha: 0.28);

        return Stack(
          alignment: Alignment.center,
          children: [
            // ── А. Внешнее пульсирующее свечение ──────────────────
            Container(
              width: widget.size + 6,
              height: widget.size + 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  // Близкое мягкое свечение (pearl-цвет)
                  BoxShadow(
                    color: pearlSoft,
                    blurRadius: 22,
                    spreadRadius: 0,
                  ),
                  // Дальнее разлитое свечение
                  BoxShadow(
                    color: pearl.withValues(alpha: 0.10),
                    blurRadius: 48,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),

            // ── Б. Переливающийся ободок (SweepGradient вращается) ─
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _PearlBorderPainter(
                t: t,
                colors: widget.pearlColors ?? _pearlColors,
              ),
            ),

            // ── Основная сфера ─────────────────────────────────────
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Тонкая белая граница поверх ободка
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.18),
                  width: 0.5,
                ),
                // Радужный радиальный градиент: ярче, чем раньше
                gradient: RadialGradient(
                  center: const Alignment(0.0, 0.0),
                  radius: 1.0,
                  colors: [
                    Colors.white.withValues(alpha: 0.01),
                    const Color(0xFFE0FFFF).withValues(alpha: 0.06),
                    pearl.withValues(alpha: 0.09),       // динамический!
                    const Color(0xFFE6E6FA).withValues(alpha: 0.16),
                  ],
                  stops: const [0.55, 0.78, 0.91, 1.0],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Контент сферы (ребёнок, фрукт, анимации)
                  // Лёгкое размытие имитирует преломление в стекле
                  ClipOval(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: child,
                    ),
                  ),

                  // ── В. Главный блик — верхний левый ───────────────
                  Positioned(
                    top: widget.size * 0.06,
                    left: widget.size * 0.10,
                    child: Container(
                      width: highlightSize,
                      height: highlightSize * 0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.size),
                        gradient: RadialGradient(
                          center: const Alignment(-0.3, -0.4),
                          radius: 1.0,
                          colors: [
                            Colors.white.withValues(alpha: 0.80),
                            Colors.white.withValues(alpha: 0.30),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.35, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // ── Дополнительный тонкий блик — правый край ──────
                  Positioned(
                    top: widget.size * 0.22,
                    right: widget.size * 0.07,
                    child: Container(
                      width: widget.size * 0.06,
                      height: widget.size * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.size),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.45),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // ── Динамический вторичный блик — нижний правый ───
                  // Меняет цвет вместе с ободком
                  Positioned(
                    bottom: widget.size * 0.09,
                    right: widget.size * 0.13,
                    child: Container(
                      width: secondarySize,
                      height: secondarySize * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.size),
                        gradient: RadialGradient(
                          colors: [
                            pearl.withValues(alpha: 0.38),
                            pearl.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// _PearlBorderPainter — вращающийся перламутровый ободок.
//
// Рисует один круг со SweepGradient (многоцветный).
// Начальный угол смещается с каждым кадром → иллюзия вращения.
// Один вызов drawCircle — минимальная нагрузка.
// ─────────────────────────────────────────────────────────────────
class _PearlBorderPainter extends CustomPainter {
  final double t;
  final List<Color> colors;

  const _PearlBorderPainter({required this.t, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1.0;
    final startAngle = t * 2 * math.pi; // медленное вращение

    // SweepGradient по всему периметру сферы
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + 2 * math.pi,
      colors: [
        ...colors.map((c) => c.withValues(alpha: 0.85)),
      ],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );
  }

  @override
  bool shouldRepaint(covariant _PearlBorderPainter old) => old.t != t;
}