import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GlassSphere extends StatelessWidget {
  final Widget child;
  final double size;

  const GlassSphere({
    super.key,
    required this.child,
    this.size = 320,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. ТЕНЬ ПОД СФЕРОЙ (Глубина)
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8E9BAE).withOpacity(0.2), // Тень цвета Sage/Blue
                  blurRadius: 40,
                  spreadRadius: -10,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
          ),

          // 2. САМО СТЕКЛО (Blur + Градиент)
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Размытие фона за сферой
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.4), // Светлый верх
                      Colors.white.withOpacity(0.1), // Прозрачный низ
                    ],
                    stops: const [0.1, 1.0],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // 3. БЛИК (Рефлекс света сверху слева)
          // ИСПРАВЛЕНИЕ: Positioned остается чистым. Анимация применяется к Container внутри.
          Positioned(
            top: size * 0.15,
            left: size * 0.15,
            child: Container(
              width: size * 0.25,
              height: size * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(size * 0.25, size * 0.15)),
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .fade(begin: 0.5, end: 0.8, duration: 2000.ms), // <--- Анимация здесь
          ),

          // 4. КОНТЕНТ ВНУТРИ (Плавает в невесомости)
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: GravityFreeActor(child: child),
          ),

          // 5. НИЖНИЙ БЛИК (Reflected light)
          Positioned(
            bottom: size * 0.1,
            right: size * 0.2,
            child: Container(
              width: size * 0.3,
              height: size * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(size * 0.3, size * 0.1)),
                  color: Colors.white.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Виджет для имитации невесомости (медленное плавание вверх-вниз)
class GravityFreeActor extends StatefulWidget {
  final Widget child;
  const GravityFreeActor({super.key, required this.child});

  @override
  State<GravityFreeActor> createState() => _GravityFreeActorState();
}

class _GravityFreeActorState extends State<GravityFreeActor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Медленный цикл
    )..repeat(reverse: true);
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
        // Синус-волна для плавности движения
        final offset = 10.0 * (0.5 - _controller.value); // Амплитуда 10 пикселей
        return Transform.translate(
          offset: Offset(0, offset),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}