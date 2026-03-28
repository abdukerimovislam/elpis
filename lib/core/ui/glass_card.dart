import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;
  final VoidCallback? onTap;

  /// Если true, отключает тяжелый BackdropFilter (размытие).
  /// Критически важно для списков (ListView), чтобы не лагало.
  final bool forceNoBlur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = 24,
    this.color,
    this.onTap,
    this.forceNoBlur = false, // По умолчанию blur включен
  });

  @override
  Widget build(BuildContext context) {
    // Базовый цвет карточки
    final themeCardColor = Theme.of(context).cardColor;

    // Если цвет не передан, берем из темы с прозрачностью
    final effectiveColor = color ?? themeCardColor.withValues(alpha: 0.65);

    // Логика: если forceNoBlur == true, мы НЕ используем блюр.
    final useBlur = !forceNoBlur;

    // Контент карточки
    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      // Если блюра нет, делаем фон чуть плотнее, чтобы текст читался
      color: useBlur ? effectiveColor : effectiveColor.withValues(alpha: 0.9),
      child: child,
    );

    // Применяем блюр только если разрешено
    if (useBlur) {
      content = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: content,
      );
    }

    // Обертка с границами и скруглением
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      ),
    );

    // Если передан onTap, добавляем эффект нажатия
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
