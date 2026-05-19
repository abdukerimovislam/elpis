import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../features/pregnancy/domain/insight.dart';
import '../../../../l10n/app_localizations.dart';

/// Возвращает основной цвет акцента для типа инсайта,
/// используя базовый [primaryColor] темы как основу.
Color insightAccentColor(InsightType type, Color primaryColor) {
  switch (type) {
    case InsightType.body:
      // Пудрово-розовый
      return Color.lerp(primaryColor, const Color(0xFFD3AABD), 0.38)!;
    case InsightType.mind:
      // Мягкий лиловый
      return Color.lerp(primaryColor, const Color(0xFFC0A5DA), 0.4)!;
    case InsightType.action:
      // Пыльно-голубой с нейтральной базой
      return Color.lerp(primaryColor, const Color(0xFFAFC2D8), 0.36)!;
    case InsightType.baby:
      // Тёплый oatmeal-rose
      return Color.lerp(primaryColor, const Color(0xFFD7C0B3), 0.34)!;
  }
}

/// Иконка-лейбл для типа инсайта.
String insightTypeLabel(BuildContext context, InsightType type) {
  final l10n = AppLocalizations.of(context)!;
  switch (type) {
    case InsightType.body:
      return l10n.insightTagForYou;
    case InsightType.mind:
      return l10n.insightTagFeelings;
    case InsightType.action:
      return l10n.insightTagTip;
    case InsightType.baby:
      return l10n.insightTagBaby;
  }
}

/// Вертикальная карточка инсайта с цветовым акцентом слева,
/// glassmorphism фоном и staggered-анимацией появления.
class WeekDetailInsightCard extends StatelessWidget {
  final Insight insight;
  final IconData iconData;
  final int staggerDelayMs;

  const WeekDetailInsightCard({
    super.key,
    required this.insight,
    required this.iconData,
    required this.staggerDelayMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final accentColor = insightAccentColor(insight.type, primaryColor);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final warmTint = Color.lerp(
      accentColor,
      const Color(0xFFFDF9FB),
      0.88,
    )!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.95),
                warmTint.withValues(alpha: 0.94),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.20),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -36,
                right: -18,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.18),
                        accentColor.withValues(alpha: 0.04),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.52, 1.0],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.14),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              iconData,
                              size: 16,
                              color: accentColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            insightTypeLabel(context, insight.type),
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w700,
                              color: accentColor.withValues(alpha: 0.86),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      insight.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: textColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      insight.content,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        height: 1.62,
                        color: mutedColor.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 450.ms, delay: staggerDelayMs.ms)
        .slideY(
          begin: 0.22,
          end: 0.0,
          duration: 520.ms,
          delay: staggerDelayMs.ms,
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1.0, 1.0),
          duration: 520.ms,
          delay: staggerDelayMs.ms,
          curve: Curves.easeOutBack,
        );
  }
}
