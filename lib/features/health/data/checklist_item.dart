import 'package:isar/isar.dart';

part 'checklist_item.g.dart';

@collection
class ChecklistItem {
  Id id;

  String title; // Название (например, "Паспорт")
  String category; // Категория (docs, mom, baby, other)
  bool isCompleted; // Галочка

  ChecklistItem({
    this.id = Isar.autoIncrement,
    required this.title,
    required this.category,
    this.isCompleted = false,
  });
}
