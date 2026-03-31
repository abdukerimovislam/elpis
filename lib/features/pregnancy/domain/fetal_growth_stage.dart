class FetalGrowthStage {
  final int fromWeek;
  final int toWeek;
  final String assetPath;
  final double startScale;
  final double endScale;
  final double startYOffset;
  final double endYOffset;

  const FetalGrowthStage({
    required this.fromWeek,
    required this.toWeek,
    required this.assetPath,
    required this.startScale,
    required this.endScale,
    required this.startYOffset,
    required this.endYOffset,
  });
}

class FetalGrowthPresentation {
  final String assetPath;
  final double scale;
  final double yOffset;
  final int stageIndex;
  final double overallProgress;
  final double weekProgress;

  const FetalGrowthPresentation({
    required this.assetPath,
    required this.scale,
    required this.yOffset,
    required this.stageIndex,
    required this.overallProgress,
    required this.weekProgress,
  });
}
