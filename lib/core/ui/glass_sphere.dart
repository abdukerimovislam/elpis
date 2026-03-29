import 'dart:ui';
import 'package:flutter/material.dart';

class GlassSphere extends StatelessWidget {
  final double size;
  final Widget child;

  const GlassSphere({
    super.key,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Вычисляем размеры бликов относительно размера сферы
    final double highlightSize = size * 0.35;
    final double reflectionSize = size * 0.7;

    return Container(
      width: size,
      height: size,
      // Основная декорация самого пузыря
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Слой 1: Очень тонкая, слегка матовая граница пузыря
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 0.5,
        ),
        // Слой 2: Радужные переливы (Иризация)
        // Используем RadialGradient, чтобы пустить цвета по краю
        gradient: RadialGradient(
          center: const Alignment(0, 0),
          radius: 1.0,
          colors: [
            // Центр почти прозрачный
            Colors.white.withOpacity(0.01),
            // Ближе к краю появляются нежные оттенки
            const Color(0xFFE0FFFF).withOpacity(0.05), // Бледно-циановый
            const Color(0xFFFFE4E1).withOpacity(0.08), // Нежно-розовый
            const Color(0xFFF0E68C).withOpacity(0.05), // Хаки/Золотистый
            // Самый край с легким фиолетовым отливом
            const Color(0xFFE6E6FA).withOpacity(0.12), // Лавандовый
          ],
          stops: const [0.6, 0.8, 0.88, 0.95, 1.0],
        ),
        boxShadow: [
          // Легкая внешняя тень/свечение для отделения от фона
          BoxShadow(
            color: const Color(0xFF98FB98).withOpacity(0.05), // Мятный оттенок
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      // Используем Stack, чтобы наложить блики ПОВЕРХ контента (ребенка)
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Слой 3: Контент внутри (Магическое ядро, Ребенок, Анимация)
          // Мы слегка размываем контент, чтобы создать эффект преломления света внутри пузыря
          ClipOval(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: child,
            ),
          ),

          // Слой 4: Основной яркий блик (источник света)
          Positioned(
            top: size * 0.08,
            left: size * 0.12,
            child: Opacity(
              opacity: 0.6,
              child: Container(
                width: highlightSize,
                height: highlightSize * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.0),
                    ],
                    stops: const [0.1, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Слой 5: Вторичный, более мягкий блик/отражение (снизу)
          Positioned(
            bottom: size * 0.1,
            right: size * 0.15,
            child: Opacity(
              opacity: 0.3,
              child: Container(
                width: reflectionSize * 0.5,
                height: reflectionSize * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFC0CB), // Розоватый отсвет
                      Colors.white.withOpacity(0.0),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}