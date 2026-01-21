import 'package:isar/isar.dart';

part 'doctor_visit.g.dart';

@collection
class DoctorVisit {
  Id id;

  @Index()
  DateTime date;           // Дата и время визита
  String title;            // Название (например, "2-й Скрининг")
  String? doctorName;      // ФИО Врача или специальность

  // --- ДО ВИЗИТА (Подготовка) ---
  String? questionsToAsk;  // Список вопросов врачу

  // --- ВО ВРЕМЯ ВИЗИТА (Показатели) ---
  double? weightKg;        // Вес на приеме
  int? bpSystolic;         // Давление (Верхнее)
  int? bpDiastolic;        // Давление (Нижнее)

  // --- ПОСЛЕ ВИЗИТА (Итоги) ---
  String? doctorNotes;     // Заключение, назначения
  bool isCompleted;        // Визит состоялся?

  DoctorVisit({
    this.id = Isar.autoIncrement,
    required this.date,
    required this.title,
    this.doctorName,
    this.questionsToAsk,
    this.weightKg,
    this.bpSystolic,
    this.bpDiastolic,
    this.doctorNotes,
    this.isCompleted = false,
  });
}