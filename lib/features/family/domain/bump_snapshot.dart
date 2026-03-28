import 'package:isar/isar.dart';

part 'bump_snapshot.g.dart';

@collection
class BumpSnapshot {
  Id id;

  @Index(unique: true, replace: true)
  int week;

  String fileName; // Храним только имя файла
  DateTime date;

  @ignore
  String? tempFullFilePath; // Поле только для UI, не сохраняется в БД

  BumpSnapshot({
    this.id = Isar.autoIncrement,
    required this.week,
    required this.fileName,
    required this.date,
  });
}
