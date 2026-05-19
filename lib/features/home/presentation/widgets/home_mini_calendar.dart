import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../pregnancy/domain/pregnancy_settings.dart';
import '../../../labor/presentation/labor_confirm_sheet.dart';

class MiniWeekNavigator extends StatelessWidget {
  final int displayWeek;
  final int realWeek;
  final bool showLaborEntry;
  final String locale;
  final String visualModeKey;
  final bool isTogglingVisualMode;
  final ValueChanged<int> onWeekSelected;
  final VoidCallback onOpenWeekPicker;
  final ValueChanged<String> onVisualModeSelected;

  const MiniWeekNavigator({
    super.key,
    required this.displayWeek,
    required this.realWeek,
    required this.showLaborEntry,
    required this.locale,
    required this.visualModeKey,
    required this.isTogglingVisualMode,
    required this.onWeekSelected,
    required this.onOpenWeekPicker,
    required this.onVisualModeSelected,
  });

  String _miniCalendarTitle(BuildContext context) {
    return AppLocalizations.of(context)!.weekNavLabel;
  }

  String _laborModeEntryLabel(BuildContext context) {
    return AppLocalizations.of(context)!.weekNavLaborMode;
  }

  IconData _visualModeIcon(String modeKey) {
    switch (modeKey) {
      case PregnancySettings.visualModeGrowth:
        return Icons.child_friendly_rounded;
      case PregnancySettings.visualModeRealistic:
        return Icons.widgets_rounded;
      default:
        return Icons.eco_rounded;
    }
  }

  String _visualModeLabel(BuildContext context, String modeKey) {
    final l10n = AppLocalizations.of(context)!;
    switch (modeKey) {
      case PregnancySettings.visualModeGrowth:
        return l10n.weekNavGrowth;
      case PregnancySettings.visualModeRealistic:
        return l10n.visualModeRealistic;
      default:
        return l10n.visualModeFruit;
    }
  }

  Widget _buildVisualModeSwitch(
    BuildContext context, {
    required ThemeData theme,
    required Color primaryColor,
  }) {
    final modes = [
      PregnancySettings.visualModeFruit,
      PregnancySettings.visualModeRealistic,
      PregnancySettings.visualModeGrowth,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6FA).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          for (final mode in modes)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: VisualModePill(
                  icon: _visualModeIcon(mode),
                  label: _visualModeLabel(context, mode),
                  isSelected: visualModeKey == mode,
                  isLoading: isTogglingVisualMode && visualModeKey == mode,
                  onTap: () => onVisualModeSelected(mode),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = AppLocalizations.of(context)!;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final startWeek = displayWeek <= 3
        ? 1
        : displayWeek >= 40
            ? 38
            : displayWeek - 2;
    final visibleWeeks = [
      for (var week = startWeek; week < startWeek + 5; week++) week,
    ];

    return Column(
      children: [
        _buildVisualModeSwitch(context,
            theme: theme, primaryColor: primaryColor),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF7FA).withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.16),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    _miniCalendarTitle(context),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: mutedColor.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onOpenWeekPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 16,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.jumpToWeek,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: primaryColor.withValues(alpha: 0.88),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  WeekArrowButton(
                    icon: Icons.chevron_left_rounded,
                    enabled: displayWeek > 1,
                    onTap: () => onWeekSelected(displayWeek - 1),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        for (final week in visibleWeeks)
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: MiniWeekChip(
                                week: week,
                                isSelected: week == displayWeek,
                                isCurrent: week == realWeek,
                                locale: locale,
                                onTap: () => onWeekSelected(week),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  WeekArrowButton(
                    icon: Icons.chevron_right_rounded,
                    enabled: displayWeek < 42,
                    onTap: () => onWeekSelected(displayWeek + 1),
                  ),
                ],
              ),
              if (showLaborEntry) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const LaborConfirmSheet(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF2EAF8),
                            Color(0xFFFBF5FA),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFD3C3E3).withValues(alpha: 0.7),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            size: 16,
                            color: Color(0xFF8268A0),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _laborModeEntryLabel(context),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF765D92),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class VisualModePill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback onTap;

  const VisualModePill({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.26)
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            else
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? primaryColor
                    : mutedColor.withValues(alpha: 0.85),
              ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.94)
                    : mutedColor.withValues(alpha: 0.88),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekArrowButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const WeekArrowButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled
              ? primaryColor.withValues(alpha: 0.14)
              : Colors.grey.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: enabled
              ? primaryColor.withValues(alpha: 0.85)
              : Colors.grey.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}

class MiniWeekChip extends StatelessWidget {
  final int week;
  final bool isSelected;
  final bool isCurrent;
  final String locale;
  final VoidCallback onTap;

  const MiniWeekChip({
    super.key,
    required this.week,
    required this.isSelected,
    required this.isCurrent,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.18)
              : const Color(0xFFFEFBFD).withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.26)
                : isCurrent
                    ? primaryColor.withValues(alpha: 0.14)
                    : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$week',
              style: theme.textTheme.titleSmall?.copyWith(
                color: isSelected
                    ? primaryColor
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 12,
              child: isCurrent
                  ? Text(
                      l10n.weekNavNow,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? primaryColor.withValues(alpha: 0.82)
                            : mutedColor.withValues(alpha: 0.72),
                        fontSize: 10,
                        letterSpacing: 0.1,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
