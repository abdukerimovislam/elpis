import 'package:flutter/material.dart';

// Убрали старый импорт
// import '../theme/app_theme.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onEditingComplete,
    this.onChanged,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final bodyStyle = theme.textTheme.bodyMedium;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines ?? 6,
        minLines: minLines ?? 1,
        onChanged: onChanged,
        style: bodyStyle?.copyWith(fontSize: 18, height: 1.4),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: bodyStyle?.copyWith(
            color: mutedColor.withValues(alpha: 0.5),
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
