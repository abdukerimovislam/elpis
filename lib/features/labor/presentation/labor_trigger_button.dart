import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloom_mama/l10n/app_localizations.dart';

class LaborTriggerButton extends StatefulWidget {
  final VoidCallback onPressed;

  const LaborTriggerButton({super.key, required this.onPressed});

  @override
  State<LaborTriggerButton> createState() => _LaborTriggerButtonState();
}

class _LaborTriggerButtonState extends State<LaborTriggerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Ð­Ñ„Ñ„ÐµÐºÑ‚ "Ð´Ñ‹Ñ…Ð°Ð½Ð¸Ñ" ÐºÐ½Ð¾Ð¿ÐºÐ¸
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
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
        return Transform.scale(
          scale: _controller.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          widget.onPressed();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF9A9E),
                Color(0xFFFECFEF)
              ], // Ð¢Ñ€ÐµÐ²Ð¾Ð¶Ð½Ñ‹Ð¹, Ð½Ð¾ Ð¼ÑÐ³ÐºÐ¸Ð¹ Ñ€Ð¾Ð·Ð¾Ð²Ñ‹Ð¹
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9A9E).withValues(alpha: 0.5),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              )
            ],
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.5), width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.laborTriggerButton,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
