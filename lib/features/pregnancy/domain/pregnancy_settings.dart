import 'package:isar/isar.dart';

part 'pregnancy_settings.g.dart';

@collection
class PregnancySettings {
  static const String visualModeFruit = 'fruit';
  static const String visualModeRealistic = 'realistic';
  static const String visualModeGrowth = 'growth';

  Id id = Isar.autoIncrement;

  DateTime estimatedDueDate;
  String? babyName;

  double? prePregnancyWeightKg;
  double? heightCm;
  String languageCode;
  String themeKey;

  bool isFruitMode;
  String visualModeKey;
  bool isLaborMode;
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
    this.themeKey = 'serenity',
    this.isFruitMode = true,
    // ИСПРАВЛЕНО: Добавлен префикс класса для корректной работы Isar Generator
    this.visualModeKey = PregnancySettings.visualModeFruit,
    this.isLaborMode = false,
    this.showLaborButton = true,
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
    String? themeKey,
    bool? isFruitMode,
    String? visualModeKey,
    bool? showLaborButton,
    bool? isLaborMode,
    String? partnerName,
    String? partnerPhone,
    String? doctorPhone,
    String? hospitalAddress,
  }) {
    final newSettings = PregnancySettings(
      estimatedDueDate: estimatedDueDate ?? this.estimatedDueDate,
      babyName: babyName ?? this.babyName,
      prePregnancyWeightKg: prePregnancyWeightKg ?? this.prePregnancyWeightKg,
      heightCm: heightCm ?? this.heightCm,
      languageCode: languageCode ?? this.languageCode,
      themeKey: themeKey ?? this.themeKey,
      isFruitMode: isFruitMode ?? this.isFruitMode,
      visualModeKey: visualModeKey ?? this.visualModeKey,
      isLaborMode: isLaborMode ?? this.isLaborMode,
      showLaborButton: showLaborButton ?? this.showLaborButton,
      partnerName: partnerName ?? this.partnerName,
      partnerPhone: partnerPhone ?? this.partnerPhone,
      doctorPhone: doctorPhone ?? this.doctorPhone,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
    );
    newSettings.id = id;
    return newSettings;
  }

  factory PregnancySettings.defaults() {
    return PregnancySettings(
      estimatedDueDate: DateTime.now().add(const Duration(days: 280)),
      themeKey: 'serenity',
      isFruitMode: true,
      // ИСПРАВЛЕНО: Добавлен префикс класса
      visualModeKey: PregnancySettings.visualModeFruit,
      showLaborButton: true,
    );
  }

  String get effectiveVisualModeKey {
    switch (visualModeKey) {
      case visualModeFruit:
      case visualModeRealistic:
      case visualModeGrowth:
        return visualModeKey;
      default:
        return isFruitMode ? visualModeFruit : visualModeRealistic;
    }
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

  // ------------------------------------------------------------------
  // ЛОГИКА ИЗОБРАЖЕНИЙ: Динамическое получение путей к ассетам
  // ------------------------------------------------------------------

  /// Возвращает путь к картинке для ТЕКУЩЕЙ недели
  @ignore
  String get currentImagePath => getImagePathForWeek(currentWeek);

  /// Возвращает путь к картинке для ЛЮБОЙ указанной недели (для свайпов)
  String getImagePathForWeek(int targetWeek) {
    // Ограничиваем неделю диапазоном, для которого есть картинки
    int safeWeek = targetWeek.clamp(4, 40);

    // Если срок меньше 4 недель, показываем начальную стадию
    if (targetWeek < 4) safeWeek = 4;
    if (targetWeek > 40) safeWeek = 40;

    switch (effectiveVisualModeKey) {
      case visualModeGrowth:
      // Режим: Развитие плода (3D рендеры)
        return 'assets/images/fetal_growth/realistic/week_$safeWeek.webp';

      case visualModeRealistic:
      // Режим: Реалистичные предметы (маковое зернышко, конфета и тд)
        return 'assets/images/realistic/week_$safeWeek.webp';

      case visualModeFruit:
      default:
      // Режим: Фрукты и овощи (по умолчанию)
        return 'assets/images/fruits/week_$safeWeek.webp';
    }
  }
}