import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class HolographicBackground extends StatefulWidget {
  final Color? baseColor;
  
  const HolographicBackground({super.key, this.baseColor});

  @override
  State<HolographicBackground> createState() => _HolographicBackgroundState();
}

class _HolographicBackgroundState extends State<HolographicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor;
    final accent = theme.colorScheme.secondary;
    final surface = theme.scaffoldBackgroundColor;

    return RepaintBoundary(
      child: Stack(
        children: [
          // Base surface color
          Positioned.fill(child: Container(color: surface)),
          
          // Animated Blobs
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _HolographicPainter(
                  t: _controller.value,
                  primary: primary,
                  accent: accent,
                ),
              );
            },
          ),
          
          // Slight glass overlay to unify colors
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: Container(
                color: surface.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HolographicPainter extends CustomPainter {
  final double t;
  final Color primary;
  final Color accent;

  _HolographicPainter({
    required this.t,
    required this.primary,
    required this.accent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    void drawBlob(Offset center, double radius, Color color) {
      paint.color = color;
      canvas.drawCircle(center, radius, paint);
    }

    final double width = size.width;
    final double height = size.height;

    // Blob 1: пудрово-розовый — плавно движется сверху
    final blob1Center = Offset(
      width * 0.2 + math.cos(t * 2 * math.pi) * width * 0.15,
      height * 0.2 + math.sin(t * 2 * math.pi) * height * 0.08,
    );
    drawBlob(blob1Center, width * 0.65, const Color(0xFFF7C6C7).withValues(alpha: 0.35));

    // Blob 2: персиковый — снизу справа
    final blob2Center = Offset(
      width * 0.78 + math.sin(t * 2 * math.pi) * width * 0.12,
      height * 0.75 + math.cos(t * 2 * math.pi) * height * 0.08,
    );
    drawBlob(blob2Center, width * 0.6, const Color(0xFFFAD4C0).withValues(alpha: 0.30));

    // Blob 3: мятный — центр слева
    final blob3Center = Offset(
      width * 0.15 + math.cos(t * 1.5 * math.pi) * 20,
      height * 0.6 + math.sin(t * 1.5 * math.pi) * 30,
    );
    drawBlob(blob3Center, width * 0.45, const Color(0xFFDCEFE6).withValues(alpha: 0.28));

    // Blob 4: лавандовый — вверху справа
    final blob4Center = Offset(
      width * 0.85 + math.sin(t * 2.5 * math.pi) * 15,
      height * 0.15 + math.cos(t * 2.5 * math.pi) * 20,
    );
    drawBlob(blob4Center, width * 0.40, const Color(0xFFE6DDF2).withValues(alpha: 0.28));
  }

  @override
  bool shouldRepaint(covariant _HolographicPainter oldDelegate) => oldDelegate.t != t;
}
