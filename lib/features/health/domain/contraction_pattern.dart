import 'contraction.dart';

bool matches511Rule(
  List<Contraction> history, {
  DateTime? now,
}) {
  if (history.length < 3) return false;

  final referenceTime = now ?? DateTime.now();
  final oneHourAgo = referenceTime.subtract(const Duration(hours: 1));
  final recentHour =
      history.where((c) => c.startTime.isAfter(oneHourAgo)).toList();

  if (recentHour.length < 6) return false;

  var longCount = 0;
  for (final contraction in recentHour) {
    if ((contraction.endTime?.difference(contraction.startTime).inSeconds ??
            0) >=
        45) {
      longCount++;
    }
  }
  final durationCondition = longCount >= (recentHour.length * 0.5);

  var validIntervalCount = 0;
  for (var i = 0; i < recentHour.length - 1; i++) {
    final diff = recentHour[i]
        .startTime
        .difference(recentHour[i + 1].startTime)
        .inMinutes;
    if (diff >= 3 && diff <= 6) {
      validIntervalCount++;
    }
  }
  final intervalCondition =
      validIntervalCount > ((recentHour.length - 1) * 0.6);

  return durationCondition && intervalCondition;
}
