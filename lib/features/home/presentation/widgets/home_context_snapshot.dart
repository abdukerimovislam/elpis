import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class HomeContextSnapshot extends StatelessWidget {
  final int displayWeek;
  final String locale;
  final String title;
  final String description;
  final double progressValue;
  final String trimesterLabel;
  final String weekLabel;

  const HomeContextSnapshot({
    super.key,
    required this.displayWeek,
    required this.locale,
    required this.title,
    required this.description,
    required this.progressValue,
    required this.trimesterLabel,
    required this.weekLabel,
  });

  String _heroSupportLine(BuildContext context, int week) {
    final l10n = AppLocalizations.of(context)!;
    if (week <= 13) return l10n.phaseBeginning;
    if (week <= 26) return l10n.phaseGrowing;
    return l10n.phaseAlmostTime;
  }

  String _weekJourneyLabel(BuildContext context, int week) {
    final l10n = AppLocalizations.of(context)!;
    if (week <= 13) return l10n.phaseBeginning;
    if (week <= 26) return l10n.phaseGrowing;
    return l10n.phaseAlmostTime;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.76),
            theme.colorScheme.surface.withValues(alpha: 0.58),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.72),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _weekJourneyLabel(context, displayWeek),
            style: theme.textTheme.labelSmall?.copyWith(
              color: primaryColor.withValues(alpha: 0.82),
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 30,
              height: 1.08,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                height: 1.58,
                color:
                    theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.72),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _heroSupportLine(context, displayWeek),
            style: theme.textTheme.labelSmall?.copyWith(
              color: primaryColor.withValues(alpha: 0.74),
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progressValue,
              backgroundColor: primaryColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(primaryColor),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CozyStatChip(
                  icon: Icons.favorite_rounded,
                  label: l10n.snapshotStage,
                  value: trimesterLabel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CozyStatChip(
                  icon: Icons.calendar_today_rounded,
                  label: l10n.snapshotNow,
                  value: weekLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CozyStatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CozyStatChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.64),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: primaryColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: mutedColor.withValues(alpha: 0.78),
                    letterSpacing: 0.8,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
