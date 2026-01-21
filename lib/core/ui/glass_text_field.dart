import 'package:flutter/material.dart';

// Убрали старый импорт
// import '../theme/app_theme.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onEditingComplete;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    // ПОЛУЧАЕМ ТЕМУ
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final bodyStyle = theme.textTheme.bodyMedium;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4), // Полупрозрачный фон (Glassmorphism обычно белый)
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.6),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: 6, // Небольшой дневник
        minLines: 1,
        // Используем стиль из темы
        style: bodyStyle?.copyWith(fontSize: 18, height: 1.4),
        // Курсор цвета темы (зеленый/синий/персиковый)
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: bodyStyle?.copyWith(
            color: mutedColor.withOpacity(0.5),
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}