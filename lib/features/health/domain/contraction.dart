import 'package:isar/isar.dart';

part 'contraction.g.dart';

@collection
class Contraction {
  Id id;

  DateTime startTime;
  DateTime? endTime;

  // Интенсивность (по ощущениям мамы): 1 - Слабо, 2 - Средне, 3 - Сильно
  int intensity;

  // Длительность в секундах (вычисляемое поле для удобства, но храним даты)
  @ignore
  int get durationInSeconds {
    if (endTime == null) return 0;
    return endTime!.difference(startTime).inSeconds;
  }

  Contraction({
    this.id = Isar.autoIncrement,
    required this.startTime,
    this.endTime,
    this.intensity = 1,
  });
}