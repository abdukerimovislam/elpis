import '../domain/fetal_growth_stage.dart';

class FetalGrowthMapper {
  static const List<FetalGrowthStage> stages = [
    // 1-4 weeks: very early abstract embryonic form.
    FetalGrowthStage(
      fromWeek: 1,
      toWeek: 4,
      assetPath: 'assets/images/fetal_growth/realistic/stage_01.png',
      startScale: 0.74,
      endScale: 0.9,
      startYOffset: 10,
      endYOffset: 5,
    ),
    // 5 week: C-shaped body, large head, first limb buds.
    FetalGrowthStage(
      fromWeek: 5,
      toWeek: 5,
      assetPath: 'assets/images/fetal_growth/realistic/stage_02.png',
      startScale: 0.84,
      endScale: 0.96,
      startYOffset: 8,
      endYOffset: 4,
    ),
    // 6 week: stronger head definition, eye pigment, longer limb buds.
    FetalGrowthStage(
      fromWeek: 6,
      toWeek: 6,
      assetPath: 'assets/images/fetal_growth/realistic/stage_03.png',
      startScale: 0.92,
      endScale: 1.02,
      startYOffset: 6,
      endYOffset: 2,
    ),
    // 7 week: clearer limbs, digit rays, tail reduction.
    FetalGrowthStage(
      fromWeek: 7,
      toWeek: 7,
      assetPath: 'assets/images/fetal_growth/realistic/stage_04.png',
      startScale: 0.98,
      endScale: 1.08,
      startYOffset: 4,
      endYOffset: 0,
    ),
    // 8-11 weeks: first clear fetal silhouette with very large head.
    FetalGrowthStage(
      fromWeek: 8,
      toWeek: 11,
      assetPath: 'assets/images/fetal_growth/realistic/stage_05.png',
      startScale: 1.02,
      endScale: 1.14,
      startYOffset: 2,
      endYOffset: 0,
    ),
    // 12-15 weeks: thinner formed limbs and more human features.
    FetalGrowthStage(
      fromWeek: 12,
      toWeek: 15,
      assetPath: 'assets/images/fetal_growth/realistic/stage_06.png',
      startScale: 1.04,
      endScale: 1.14,
      startYOffset: 2,
      endYOffset: -2,
    ),
    // 16-19 weeks: clearer anatomy and finger definition.
    FetalGrowthStage(
      fromWeek: 16,
      toWeek: 19,
      assetPath: 'assets/images/fetal_growth/realistic/stage_07.png',
      startScale: 1.1,
      endScale: 1.22,
      startYOffset: 0,
      endYOffset: -2,
    ),
    // 20-23 weeks: balanced human proportions.
    FetalGrowthStage(
      fromWeek: 20,
      toWeek: 23,
      assetPath: 'assets/images/fetal_growth/realistic/stage_08.png',
      startScale: 1.16,
      endScale: 1.3,
      startYOffset: 0,
      endYOffset: -4,
    ),
    // 24-27 weeks: slimmer body with more defined face.
    FetalGrowthStage(
      fromWeek: 24,
      toWeek: 27,
      assetPath: 'assets/images/fetal_growth/realistic/stage_09.png',
      startScale: 1.22,
      endScale: 1.36,
      startYOffset: -2,
      endYOffset: -5,
    ),
    // 28-31 weeks: smoother skin, more fat, tighter pose.
    FetalGrowthStage(
      fromWeek: 28,
      toWeek: 31,
      assetPath: 'assets/images/fetal_growth/realistic/stage_10.png',
      startScale: 1.28,
      endScale: 1.42,
      startYOffset: -2,
      endYOffset: -6,
    ),
    // 32-35 weeks: rounder body and fuller face.
    FetalGrowthStage(
      fromWeek: 32,
      toWeek: 35,
      assetPath: 'assets/images/fetal_growth/realistic/stage_11.png',
      startScale: 1.34,
      endScale: 1.46,
      startYOffset: -4,
      endYOffset: -6,
    ),
    // 36-39 weeks: almost newborn, fully formed proportions.
    FetalGrowthStage(
      fromWeek: 36,
      toWeek: 39,
      assetPath: 'assets/images/fetal_growth/realistic/stage_12.png',
      startScale: 1.42,
      endScale: 1.54,
      startYOffset: -4,
      endYOffset: -8,
    ),
    // 40 week: full-term final stage.
    FetalGrowthStage(
      fromWeek: 40,
      toWeek: 40,
      assetPath: 'assets/images/fetal_growth/realistic/stage_13.png',
      startScale: 1.46,
      endScale: 1.68,
      startYOffset: -8,
      endYOffset: -12,
    ),
  ];

  static FetalGrowthPresentation forWeek(int week) {
    final safeWeek = week.clamp(1, 40);
    final stageIndex = stages.indexWhere(
      (stage) => safeWeek >= stage.fromWeek && safeWeek <= stage.toWeek,
    );
    final stage = stageIndex == -1 ? stages.last : stages[stageIndex];

    final span = (stage.toWeek - stage.fromWeek).clamp(1, 40);
    final progress = ((safeWeek - stage.fromWeek) / span).clamp(0.0, 1.0);
    final overallProgress = ((safeWeek - 1) / 39).clamp(0.0, 1.0);
    final growthBoost = _lerp(0.0, 0.14, overallProgress);
    final weekNudge = _lerp(-2.0, 2.0, progress);

    return FetalGrowthPresentation(
      assetPath: stage.assetPath,
      scale: _lerp(stage.startScale, stage.endScale, progress) + growthBoost,
      yOffset:
          _lerp(stage.startYOffset, stage.endYOffset, progress) + weekNudge,
      stageIndex: stageIndex == -1 ? stages.length : stageIndex + 1,
      overallProgress: overallProgress,
      weekProgress: progress,
    );
  }

  static double _lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
