import 'package:isar/isar.dart';

part 'week_snapshot.g.dart';

@collection
class WeekSnapshot {
  Id id;

  @Index(unique: true, replace: true)
  int week;

  double? weightKg;
  double? bellyGirthCm;
  String? notes;

  String? letterToBaby;
  List<String>? photoPaths;
  DateTime? date;

  WeekSnapshot({
    this.id = Isar.autoIncrement,
    required this.week,
    this.weightKg,
    this.bellyGirthCm,
    this.notes,
    this.letterToBaby,
    this.photoPaths,
    this.date, // <--- ДОБАВЛЕНО В КОНСТРУКТОР
  });
}