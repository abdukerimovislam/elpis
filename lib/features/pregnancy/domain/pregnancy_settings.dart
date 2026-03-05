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
  bool isLaborMode;

  // 🔥 НОВОЕ ПОЛЕ: Показывать ли кнопку родов
  bool showLaborButton;

  String? partnerName;
  String? partnerPhone;
  String? doctorPhone;
  String? hospitalAddress;

  PregnancySettings({
    required this.estimatedDueDate,
    this.babyName,
    this.prePregnancyWeightKg,
    this.heightCm,
    this.languageCode = 'en',
    this.isFruitMode = true,
    this.themeKey = 'serenity',
    this.isLaborMode = false,
    this.showLaborButton = true, // По умолчанию true
    this.partnerName,
    this.partnerPhone,
    this.doctorPhone,
    this.hospitalAddress,
  });

  PregnancySettings copyWith({
    DateTime? estimatedDueDate,
    String? babyName,
    double? prePregnancyWeightKg,
    double? heightCm,
    String? languageCode,
    bool? isFruitMode,
    String? themeKey,
    bool? showLaborButton, // Аргумент
  }) {
    final newSettings = PregnancySettings(
      estimatedDueDate: estimatedDueDate ?? this.estimatedDueDate,
      babyName: babyName ?? this.babyName,
      prePregnancyWeightKg: prePregnancyWeightKg ?? this.prePregnancyWeightKg,
      heightCm: heightCm ?? this.heightCm,
      languageCode: languageCode ?? this.languageCode,
      isFruitMode: isFruitMode ?? this.isFruitMode,
      themeKey: themeKey ?? this.themeKey,
      isLaborMode: this.isLaborMode,
      showLaborButton: showLaborButton ?? this.showLaborButton, // Копируем
      partnerName: this.partnerName,
      partnerPhone: this.partnerPhone,
      doctorPhone: this.doctorPhone,
      hospitalAddress: this.hospitalAddress,
    );
    newSettings.id = this.id;
    return newSettings;
  }

  factory PregnancySettings.defaults() {
    return PregnancySettings(
      estimatedDueDate: DateTime.now().add(const Duration(days: 280)),
      isFruitMode: true,
      themeKey: 'serenity',
      showLaborButton: true, // По умолчанию true
    );
  }

  int get currentWeek {
    final now = DateTime.now();
    final conceptionDate = estimatedDueDate.subtract(const Duration(days: 280));
    final difference = now.difference(conceptionDate);
    final week = (difference.inDays / 7).floor() + 1;
    if (week < 1) return 1;
    if (week > 42) return 42;
    return week;
  }
}