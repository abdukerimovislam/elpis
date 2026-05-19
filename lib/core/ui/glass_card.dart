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
    final themeCardColor = Theme.of(context).cardColor;
    final effectiveColor = color ?? themeCardColor.withValues(alpha: 0.94);
    final useBlur = !forceNoBlur;

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      color: useBlur ? effectiveColor : effectiveColor.withValues(alpha: 0.98),
      child: child,
    );

    if (useBlur) {
      content = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: content,
      );
    }

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.72),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
