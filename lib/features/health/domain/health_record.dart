import 'package:isar/isar.dart';

part 'health_record.g.dart';

@collection
class HealthRecord {
  Id id;

  // УЛУЧШЕНИЕ: unique: true
  // Это гарантирует, что в базе не будет дубликатов за один и тот же день.
  // Если мы попытаемся сохранить запись с такой же датой, Isar выбросит ошибку (или заменит, если replace: true),
  // что защитит нас от багов дублирования данных на графиках.
  @Index(unique: true)
  DateTime date;

  // Настроение и Симптомы
  int? moodRating;
  List<String>? symptoms;
  String? note;

  // Вес
  double? weightKg;

  // Вода (Feature #4)
  int waterGlasses;

  // Пинки (Feature #3) - Сводка за день
  int totalKicks;
  int kickSessionsCount;

  HealthRecord({
    this.id = Isar.autoIncrement,
    required this.date,
    this.moodRating,
    this.weightKg,
    this.symptoms,
    this.waterGlasses = 0,
    this.note,
    this.totalKicks = 0,
    this.kickSessionsCount = 0,
  });
}
