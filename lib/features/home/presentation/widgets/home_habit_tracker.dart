import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../l10n/app_localizations.dart';

class HomeHabitTracker extends StatefulWidget {
  final String locale;

  const HomeHabitTracker({
    super.key,
    required this.locale,
  });

  @override
  State<HomeHabitTracker> createState() => _HomeHabitTrackerState();
}

class _HomeHabitTrackerState extends State<HomeHabitTracker> {
  int? _selectedMood;
  final List<bool> _habits = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = theme.primaryColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.monitor_heart_rounded, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.habitTrackerTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.habitTrackerQuestion,
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMoodButton(
                index: 0,
                emoji: '😴',
                label: l10n.habitMoodTired,
                primaryColor: primaryColor,
              ),
              _buildMoodButton(
                index: 1,
                emoji: '😊',
                label: l10n.habitMoodGood,
                primaryColor: primaryColor,
              ),
              _buildMoodButton(
                index: 2,
                emoji: '✨',
                label: l10n.habitMoodGreat,
                primaryColor: primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0EBF5)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHabitPill(
                index: 0,
                icon: Icons.water_drop_rounded,
                label: l10n.habitWater,
                primaryColor: primaryColor,
              ),
              _buildHabitPill(
                index: 1,
                icon: Icons.directions_walk_rounded,
                label: l10n.habitWalk,
                primaryColor: primaryColor,
              ),
              _buildHabitPill(
                index: 2,
                icon: Icons.medication_rounded,
                label: l10n.habitVitamins,
                primaryColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton({required int index, required String emoji, required String label, required Color primaryColor}) {
    final isSelected = _selectedMood == index;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedMood = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primaryColor : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitPill({required int index, required IconData icon, required String label, required Color primaryColor}) {
    final isChecked = _habits[index];
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        setState(() => _habits[index] = !isChecked);
      },
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOutBack,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isChecked ? primaryColor : primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isChecked ? Colors.white : primaryColor.withValues(alpha: 0.8),
            ),
            if (isChecked) ...[
              const SizedBox(width: 6),
              const Icon(Icons.check_rounded, size: 14, color: Colors.white),
            ]
          ],
        ),
      ),
    );
  }
}
