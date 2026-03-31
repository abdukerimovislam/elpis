import 'package:flutter/material.dart';

import '../../../../core/ui/optimized_image.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/fetal_growth_mapper.dart';

class FetalGrowthSection extends StatefulWidget {
  final int week;

  const FetalGrowthSection({
    super.key,
    required this.week,
  });

  @override
  State<FetalGrowthSection> createState() => _FetalGrowthSectionState();
}

class _FetalGrowthSectionState extends State<FetalGrowthSection> {
  int _weekTransitionDirection = 1;

  @override
  void didUpdateWidget(covariant FetalGrowthSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.week == oldWidget.week) {
      return;
    }

    _weekTransitionDirection = widget.week >= oldWidget.week ? 1 : -1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final data = FetalGrowthMapper.forWeek(widget.week);
    final safeWeek = widget.week.clamp(1, 40);
    final imageHeight = 220 + (data.overallProgress * 72);
    final haloOpacity = 0.08 + (data.overallProgress * 0.16);
    final tilt = -0.04 + (data.weekProgress * 0.08);
    final direction = _weekTransitionDirection.toDouble();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.growthSectionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.growthSectionSubtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: (theme.textTheme.bodySmall?.color ?? Colors.black87)
                  .withValues(alpha: 0.68),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _GrowthChip(label: l10n.weekLabel(safeWeek)),
              _GrowthChip(
                label: l10n.growthStage(data.stageIndex),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.primaryColor.withValues(alpha: 0.04),
                  theme.primaryColor.withValues(alpha: 0.015),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.15),
                        radius: 0.9,
                        colors: [
                          theme.primaryColor.withValues(alpha: haloOpacity),
                          theme.primaryColor.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.78],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 180 + (data.overallProgress * 70),
                  height: 180 + (data.overallProgress * 70),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(
                          alpha: 0.08 + (data.overallProgress * 0.12),
                        ),
                        blurRadius: 34 + (data.overallProgress * 16),
                        spreadRadius: 10 + (data.overallProgress * 12),
                      ),
                    ],
                  ),
                ),
                TweenAnimationBuilder<double>(
                  key: ValueKey<String>(
                      'growth_panel_${data.assetPath}_$safeWeek'),
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 860),
                  curve: Curves.easeOutCubic,
                  builder: (context, t, child) {
                    final imageSlideX = (1 - t) * 24 * direction;
                    final imageSlideY = data.yOffset + (1 - t) * 14;
                    final backdropSlideX = (1 - t) * -14 * direction;
                    final animatedScale = data.scale * (0.9 + (t * 0.1));
                    final animatedRotation =
                        tilt + ((1 - t) * -0.06 * direction);
                    final animatedHaloSize = 180 + (data.overallProgress * 70);

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(backdropSlideX, 0),
                          child: Opacity(
                            opacity: 0.35 + (t * 0.65),
                            child: Container(
                              width: animatedHaloSize,
                              height: animatedHaloSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withValues(
                                      alpha:
                                      0.08 + (data.overallProgress * 0.12),
                                    ),
                                    blurRadius:
                                    34 + (data.overallProgress * 16),
                                    spreadRadius:
                                    10 + (data.overallProgress * 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(imageSlideX, imageSlideY),
                          child: Opacity(
                            opacity: 0.2 + (t * 0.8),
                            child: Transform.rotate(
                              angle: animatedRotation,
                              child: Transform.scale(
                                scale: animatedScale,
                                child: child,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: OptimizedImage(
                    path: data.assetPath,
                    height: imageHeight,
                    memCacheWidth: 1200,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrowthChip extends StatelessWidget {
  final String label;

  const _GrowthChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}