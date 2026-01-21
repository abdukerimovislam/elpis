import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

// Убрали старые импорты стилей
// import '../../../core/theme/app_theme.dart';

import '../data/health_repository.dart'; // Или pregnancy_repository.dart, если объединили

class WaterSheet extends ConsumerStatefulWidget {
  const WaterSheet({super.key});

  @override
  ConsumerState<WaterSheet> createState() => _WaterSheetState();
}

class _WaterSheetState extends ConsumerState<WaterSheet> {
  int _glasses = 0;
  final int _goal = 8;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final record = await ref.read(healthRepositoryProvider).getRecordForDate(DateTime.now());
    if (mounted) {
      setState(() {
        _glasses = record.waterGlasses;
      });
    }
  }

  void _updateWater(int delta) {
    final newValue = (_glasses + delta).clamp(0, 15);
    setState(() => _glasses = newValue);

    if (delta > 0) {
      ref.read(healthRepositoryProvider).addWaterGlass(DateTime.now());
    } else {
      ref.read(healthRepositoryProvider).removeWaterGlass(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;

    final progress = (_glasses / _goal).clamp(0.0, 1.0);

    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor, // Динамический фон
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: mutedColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2)
              )
          ),
          const SizedBox(height: 32),

          Text(
              l10n.waterTitle,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
          ),
          const SizedBox(height: 8),
          Text(
            l10n.waterFact,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor, fontSize: 14),
          ),

          const Spacer(),

          // ВИЗУАЛИЗАЦИЯ (КРУГ)
          Stack(
            alignment: Alignment.center,
            children: [
              // Фон круга
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Вода всегда голубая, не зависимо от темы
                  border: Border.all(color: const Color(0xFFE0F7FA), width: 2),
                ),
              ),
              // Наполнение (Анимированное)
              AnimatedContainer(
                duration: 600.ms,
                curve: Curves.easeOutBack,
                width: 200 * (0.2 + progress * 0.8),
                height: 200 * (0.2 + progress * 0.8),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2EBF2).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              // Цифра
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "$_glasses",
                      style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: mainTextColor
                      )
                  ),
                  Text(
                      l10n.waterProgress(_goal),
                      style: theme.textTheme.labelSmall
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // КНОПКИ + / -
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(Icons.remove, () => _updateWater(-1), theme),
              const SizedBox(width: 40),
              _buildButton(Icons.add, () => _updateWater(1), theme, isPrimary: true),
            ],
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap, ThemeData theme, {bool isPrimary = false}) {
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryBg = theme.colorScheme.surfaceContainerHighest ?? Colors.grey.shade200;

    Widget button = Container(
      width: 64, height: 64,
      decoration: BoxDecoration(
        // Для кнопки "+" используем голубой (вода), для "-" нейтральный фон темы
        color: isPrimary ? const Color(0xFFE0F7FA) : secondaryBg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 32, color: mainTextColor),
    );

    Widget clickable = GestureDetector(onTap: onTap, child: button);

    if (isPrimary) {
      return clickable
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(end: 1.1, duration: 1.5.seconds, curve: Curves.easeInOut);
    }

    return clickable;
  }
}