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
    this.visualModeKey = visualModeFruit,
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
      visualModeKey: visualModeFruit,
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
}
