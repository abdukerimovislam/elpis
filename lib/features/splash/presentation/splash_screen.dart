import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/ui/holographic_background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ec = Theme.of(context).elpisColors;
    
    return Scaffold(
      backgroundColor: ec.milky,
      body: Stack(
        children: [
          // 1. Мягкое базовое свечение
          const HolographicBackground(),
          
          // 2. Воздушные пузырьки / капли
          const FloatingBubbles(),
          
          // 3. Текст
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Главное лого: Легкий, ультратонкий и широкий шрифт
                Text(
                  'ELPIS',
                  style: GoogleFonts.montserrat(
                    fontSize: 52,
                    fontWeight: FontWeight.w200, // Ультра-тонкий
                    color: ec.textBrown.withValues(alpha: 0.9),
                    letterSpacing: 16.0, // Очень широкий
                  ),
                )
                .animate()
                .fadeIn(duration: 1200.ms, curve: Curves.easeOut)
                .scaleXY(begin: 0.9, end: 1.0, duration: 1200.ms, curve: Curves.easeOutCubic),
                
                const SizedBox(height: 20),
                
                // Подзаголовок: Воздушный и аккуратный
                Text(
                  'AURA OF MOTHERHOOD',
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 6.0,
                    color: ec.dustyRose.withValues(alpha: 0.8),
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 1200.ms, curve: Curves.easeOut)
                .slideY(begin: 0.3, end: 0, duration: 1200.ms, curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// АНИМАЦИЯ ВОЗДУШНЫХ ПУЗЫРЬКОВ / КАПЕЛЬ
// -----------------------------------------------------------------------------

class FloatingBubbles extends StatefulWidget {
  const FloatingBubbles({super.key});

  @override
  State<FloatingBubbles> createState() => _FloatingBubblesState();
}

class _FloatingBubblesState extends State<FloatingBubbles> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final int bubbleCount = 18;
  late List<Bubble> _bubbles;
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    // Очень медленная и плавная анимация длительностью 15 секунд
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 15))..repeat();
    
    // Генерируем случайные параметры для пузырьков
    _bubbles = List.generate(bubbleCount, (index) {
      return Bubble(
        x: random.nextDouble(), // 0.0 - 1.0
        y: random.nextDouble(), // 0.0 - 1.0
        size: random.nextDouble() * 40 + 10, // Размер от 10 до 50
        speed: random.nextDouble() * 0.3 + 0.1, // Медленная скорость
        opacity: random.nextDouble() * 0.15 + 0.05, // Очень полупрозрачные
        wobbleSpeed: random.nextDouble() * 2 + 1, // Скорость покачивания
        wobbleAmount: random.nextDouble() * 0.05, // Амплитуда покачивания по X
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblePainter(_bubbles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Bubble {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final double wobbleSpeed;
  final double wobbleAmount;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.wobbleSpeed,
    required this.wobbleAmount,
  });
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final double animationValue;

  BubblePainter(this.bubbles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      // Плавное движение вверх
      double currentY = bubble.y - (animationValue * bubble.speed);
      
      // Зацикливание: если ушел наверх, возвращаем вниз
      if (currentY < -0.1) {
        currentY = 1.1 + currentY;
      }

      // Добавляем эффект легкого покачивания влево-вправо (эффект воды/воздуха)
      double currentX = bubble.x + math.sin(animationValue * math.pi * 2 * bubble.wobbleSpeed) * bubble.wobbleAmount;

      final center = Offset(currentX * size.width, currentY * size.height);
      final radius = bubble.size;

      // 1. Внутренняя заливка (мягкий объем)
      final fillPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: bubble.opacity * 0.8),
            Colors.white.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.fill;

      // 2. Четкий контур пузырька (тонкая грань)
      final strokePaint = Paint()
        ..color = Colors.white.withValues(alpha: bubble.opacity * 2.5) // Делаем контур более заметным
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      // 3. Блик для создания 3D-эффекта (стекло/вода)
      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: bubble.opacity * 3.5)
        ..style = PaintingStyle.fill;

      // Рисуем тело и контур
      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, strokePaint);

      // Рисуем блик (сверху слева)
      // Поворачиваем блик под небольшим углом
      canvas.save();
      canvas.translate(center.dx - radius * 0.35, center.dy - radius * 0.35);
      canvas.rotate(-math.pi / 6);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: radius * 0.5,
          height: radius * 0.15,
        ),
        highlightPaint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
}
