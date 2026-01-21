import 'package:isar/isar.dart';

part 'pregnancy_settings.g.dart';

@collection
class PregnancySettings {
  Id id = Isar.autoIncrement;

  DateTime estimatedDueDate;
  String? babyName;

  double? prePregnancyWeightKg;
  double? heightCm;
  String languageCode;
  String themeKey;

  bool isFruitMode;
  bool isLaborMode; // Включен ли режим родов

  String? partnerName;
  String? partnerPhone; // Номер телефона партнера
  String? doctorPhone;  // Номер врача
  String? hospitalAddress; // Адрес роддома для такси

  PregnancySettings({
    required this.estimatedDueDate,
    this.babyName,
    this.prePregnancyWeightKg,
    this.heightCm,
    this.languageCode = 'en',
    this.isFruitMode = true,
    this.themeKey = 'serenity',
    this.isLaborMode = false,
    this.partnerName,
    this.partnerPhone,
    this.doctorPhone,
    this.hospitalAddress,
  });

  // ИСПРАВЛЕННЫЙ copyWith
  PregnancySettings copyWith({
    DateTime? estimatedDueDate,
    String? babyName,
    double? prePregnancyWeightKg,
    double? heightCm,
    String? languageCode,
    bool? isFruitMode,
    String? themeKey, // Добавил этот аргумент

  }) {
    // Создаем новый объект
    final newSettings = PregnancySettings(
      estimatedDueDate: estimatedDueDate ?? this.estimatedDueDate,
      babyName: babyName ?? this.babyName,
      prePregnancyWeightKg: prePregnancyWeightKg ?? this.prePregnancyWeightKg,
      heightCm: heightCm ?? this.heightCm,
      languageCode: languageCode ?? this.languageCode,
      isFruitMode: isFruitMode ?? this.isFruitMode,
      themeKey: themeKey ?? this.themeKey, // Передаем тему
    );

    // ВАЖНО: Копируем ID старого объекта!
    // Иначе Isar создаст дубликат записи в базе.
    newSettings.id = this.id;

    return newSettings;
  }

  factory PregnancySettings.defaults() {
    return PregnancySettings(
      estimatedDueDate: DateTime.now().add(const Duration(days: 280)),
      isFruitMode: true,
      themeKey: 'serenity',
    );
  }

  // Расчет текущей недели (Safe Mode)
  int get currentWeek {
    final now = DateTime.now();
    final conceptionDate = estimatedDueDate.subtract(const Duration(days: 280));
    final difference = now.difference(conceptionDate);

    final week = (difference.inDays / 7).floor() + 1;

    // Ограничиваем диапазон от 1 до 42, чтобы UI не ломался
    if (week < 1) return 1;
    if (week > 42) return 42;
    return week;
  }
}