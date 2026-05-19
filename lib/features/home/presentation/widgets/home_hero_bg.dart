import 'package:flutter/material.dart';

class WarmGlowBackground extends StatelessWidget {
  const WarmGlowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -80,
            child: _GlowBlob(
              size: 280,
              color: primaryColor.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            top: 240,
            right: -70,
            child: _GlowBlob(
              size: 220,
              color: const Color(0xFFEDE7F1).withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            bottom: 120,
            left: -90,
            child: _GlowBlob(
              size: 260,
              color: const Color(0xFFF4ECEF).withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowBlob({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: color.a * 0.45),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
      ),
    );
  }
}
