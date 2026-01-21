import 'package:flutter/foundation.dart'; // Для debugPrint
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ИМПОРТ ЛОКАЛИЗАЦИИ
import '../../../l10n/app_localizations.dart';

// ИМПОРТЫ МОДЕЛЕЙ
import '../domain/week_snapshot.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../health/domain/health_record.dart';
import '../../health/domain/contraction.dart';
import '../../health/data/checklist_item.dart';
import '../../health/domain/doctor_visit.dart';
import '../../family/domain/baby_name.dart';
import '../../family/domain/bump_snapshot.dart';

part 'pregnancy_repository.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarDatabase(IsarDatabaseRef ref) async {
  final dir = await getApplicationDocumentsDirectory();

  return Isar.open(
    [
      WeekSnapshotSchema,
      PregnancySettingsSchema,
      HealthRecordSchema,
      ContractionSchema,
      ChecklistItemSchema,
      DoctorVisitSchema,
      BabyNameSchema,
      BumpSnapshotSchema,
    ],
    directory: dir.path,
    inspector: true,
  );
}

@Riverpod(keepAlive: true)
PregnancyRepository pregnancyRepository(PregnancyRepositoryRef ref) {
  final isarAsync = ref.watch(isarDatabaseProvider);

  if (isarAsync.isLoading || isarAsync.hasError) {
    throw UnimplementedError('Database is not ready yet');
  }

  return PregnancyRepository(isarAsync.requireValue);
}

class PregnancyRepository {
  final Isar _isar;

  PregnancyRepository(this._isar);

  // -------------------------------------------------------
  // ---🛡️ SAFETY WRAPPER (ЗАЩИТА ОТ ПАДЕНИЙ) ---
  // -------------------------------------------------------

  Future<void> _safeWrite(Future<void> Function() action) async {
    try {
      await _isar.writeTxn(action);
    } catch (e, stack) {
      debugPrint("🛑 DATABASE ERROR: $e");
      debugPrint(stack.toString());
    }
  }

  // -------------------------------------------------------
  // --- SETTINGS (Настройки) ---
  // -------------------------------------------------------

  Future<void> saveDueDate(DateTime date, {String? name}) async {
    await updateSettings(dueDate: date, name: name);
  }

  Future<void> setTheme(String key) async {
    await updateSettings(themeKey: key);
  }

  Future<void> setFruitMode(bool isFruit) async {
    await updateSettings(isFruitMode: isFruit);
  }

  /// ОБНОВЛЕННЫЙ МЕТОД: Теперь принимает поля для Labor Mode
  Future<void> updateSettings({
    String? name,
    DateTime? dueDate,
    double? prePregnancyWeight,
    double? height,
    String? languageCode,
    bool? isFruitMode,
    String? themeKey,
    // --- Новые поля для режима родов ---
    bool? isLaborMode,
    String? partnerName,
    String? partnerPhone,
    String? doctorPhone,
    String? hospitalAddress,
  }) async {
    await _safeWrite(() async {
      final settings = await _isar.pregnancySettings.where().findFirst();

      if (settings != null) {
        // Обновляем существующие настройки
        if (name != null) settings.babyName = name;
        if (dueDate != null) settings.estimatedDueDate = dueDate;
        if (prePregnancyWeight != null) settings.prePregnancyWeightKg = prePregnancyWeight;
        if (height != null) settings.heightCm = height;
        if (languageCode != null) settings.languageCode = languageCode;
        if (isFruitMode != null) settings.isFruitMode = isFruitMode;
        if (themeKey != null) settings.themeKey = themeKey;

        // Обновляем поля режима родов
        if (isLaborMode != null) settings.isLaborMode = isLaborMode;
        if (partnerName != null) settings.partnerName = partnerName;
        if (partnerPhone != null) settings.partnerPhone = partnerPhone;
        if (doctorPhone != null) settings.doctorPhone = doctorPhone;
        if (hospitalAddress != null) settings.hospitalAddress = hospitalAddress;

        await _isar.pregnancySettings.put(settings);
      } else {
        // Создаем новые, если их не было
        final newSettings = PregnancySettings(
          estimatedDueDate: dueDate ?? DateTime.now().add(const Duration(days: 280)),
          babyName: name,
          prePregnancyWeightKg: prePregnancyWeight,
          heightCm: height,
          languageCode: languageCode ?? 'en',
          isFruitMode: isFruitMode ?? true,
          themeKey: themeKey ?? 'serenity',
          // Defaults for Labor Mode
          isLaborMode: isLaborMode ?? false,
          partnerName: partnerName,
          partnerPhone: partnerPhone,
          doctorPhone: doctorPhone,
          hospitalAddress: hospitalAddress,
        );
        await _isar.pregnancySettings.put(newSettings);
      }
    });
  }

  Future<int?> getCurrentWeek() async {
    final settings = await _isar.pregnancySettings.where().findFirst();
    if (settings == null) return null;
    return settings.currentWeek;
  }

  Future<PregnancySettings?> getSettings() async {
    return _isar.pregnancySettings.where().findFirst();
  }

  Stream<PregnancySettings?> watchSettings() {
    return _isar.pregnancySettings.where().watch(fireImmediately: true).map((e) => e.firstOrNull);
  }

  // -------------------------------------------------------
  // --- WEEK SNAPSHOTS (Дневник / Письма) ---
  // -------------------------------------------------------

  Future<WeekSnapshot> getOrCreateSnapshot(int week) async {
    final existing = await _isar.weekSnapshots.filter().weekEqualTo(week).findFirst();
    if (existing != null) return existing;
    return WeekSnapshot(week: week);
  }

  Future<void> saveLetter(int week, String letter) async {
    await _safeWrite(() async {
      var snapshot = await _isar.weekSnapshots.filter().weekEqualTo(week).findFirst();
      if (snapshot == null) {
        snapshot = WeekSnapshot(week: week);
      }
      snapshot.letterToBaby = letter;
      snapshot.date = DateTime.now();
      await _isar.weekSnapshots.put(snapshot);
    });
  }

  Future<List<WeekSnapshot>> getDiaryHistory() async {
    final list = await _isar.weekSnapshots
        .filter()
        .letterToBabyIsNotNull()
        .and()
        .letterToBabyIsNotEmpty()
        .findAll();
    list.sort((a, b) => b.week.compareTo(a.week));
    return list;
  }

  Stream<List<WeekSnapshot>> watchDiaryHistory() {
    return _isar.weekSnapshots
        .filter()
        .letterToBabyIsNotNull()
        .and()
        .letterToBabyIsNotEmpty()
        .sortByWeekDesc()
        .watch(fireImmediately: true);
  }

  // -------------------------------------------------------
  // --- HEALTH RECORD (Вес, Вода, Пинки, Симптомы) ---
  // -------------------------------------------------------

  Future<HealthRecord> _getOrCreateHealthRecord(DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);
    final existing = await _isar.healthRecords.filter().dateEqualTo(day).findFirst();
    return existing ?? HealthRecord(date: day);
  }

  Future<void> saveWeight(double weight, DateTime date) async {
    await _safeWrite(() async {
      final record = await _getOrCreateHealthRecord(date);
      record.weightKg = weight;
      await _isar.healthRecords.put(record);
    });
  }

  Stream<List<HealthRecord>> watchWeights() {
    return _isar.healthRecords
        .filter()
        .weightKgIsNotNull()
        .sortByDate()
        .watch(fireImmediately: true);
  }

  Future<List<HealthRecord>> getWeights() async {
    return _isar.healthRecords
        .filter()
        .weightKgIsNotNull()
        .sortByDate()
        .findAll();
  }

  Future<void> addWaterGlass(DateTime date) async {
    await _safeWrite(() async {
      final record = await _getOrCreateHealthRecord(date);
      record.waterGlasses += 1;
      await _isar.healthRecords.put(record);
    });
  }

  Future<void> removeWaterGlass(DateTime date) async {
    await _safeWrite(() async {
      final record = await _getOrCreateHealthRecord(date);
      if (record.waterGlasses > 0) {
        record.waterGlasses -= 1;
        await _isar.healthRecords.put(record);
      }
    });
  }

  Future<HealthRecord> getRecordForDate(DateTime date) async {
    return _getOrCreateHealthRecord(date);
  }

  Future<void> saveSymptoms({
    required DateTime date,
    required List<String> symptoms,
    required int mood
  }) async {
    await _safeWrite(() async {
      final record = await _getOrCreateHealthRecord(date);
      record.symptoms = symptoms;
      record.moodRating = mood;
      await _isar.healthRecords.put(record);
    });
  }

  Future<void> saveKickSession({required DateTime date, required int kicks}) async {
    await _safeWrite(() async {
      final record = await _getOrCreateHealthRecord(date);
      record.totalKicks += kicks;
      record.kickSessionsCount += 1;
      await _isar.healthRecords.put(record);
    });
  }

  Future<List<HealthRecord>> getKickHistory() async {
    return _isar.healthRecords
        .filter()
        .totalKicksGreaterThan(0)
        .sortByDateDesc()
        .findAll();
  }

  Stream<List<HealthRecord>> watchKickHistory() {
    return _isar.healthRecords
        .filter()
        .totalKicksGreaterThan(0)
        .sortByDateDesc()
        .watch(fireImmediately: true);
  }

  // -------------------------------------------------------
  // --- GENERAL UTILS (Очистка) ---
  // -------------------------------------------------------

  Future<void> clearAllData() async {
    await _safeWrite(() async {
      await _isar.writeTxn(() async {
        await _isar.clear(); // Полная очистка всей базы
      });
    });
  }

  // -------------------------------------------------------
  // --- CONTRACTIONS ---
  // -------------------------------------------------------

  Future<Contraction?> getActiveContraction() async {
    return _isar.contractions.filter().endTimeIsNull().findFirst();
  }

  Future<Contraction> startContraction() async {
    final c = Contraction(startTime: DateTime.now());
    await _safeWrite(() async {
      await _isar.contractions.put(c);
    });
    return c;
  }

  Future<void> stopContraction(Id id) async {
    await _safeWrite(() async {
      final c = await _isar.contractions.get(id);
      if (c != null) {
        c.endTime = DateTime.now();
        await _isar.contractions.put(c);
      }
    });
  }

  Stream<List<Contraction>> watchContractions() {
    return _isar.contractions.where().sortByStartTimeDesc().watch(fireImmediately: true);
  }

  Future<void> clearContractions() async {
    await _safeWrite(() async {
      await _isar.contractions.clear();
    });
  }

  // -------------------------------------------------------
  // --- DOCTOR VISITS ---
  // -------------------------------------------------------

  Future<void> saveVisit(DoctorVisit visit) async {
    await _safeWrite(() async {
      await _isar.doctorVisits.put(visit);
    });
  }

  Stream<List<DoctorVisit>> watchAllVisits() {
    return _isar.doctorVisits.where().sortByDate().watch(fireImmediately: true);
  }

  Future<void> deleteVisit(Id id) async {
    await _safeWrite(() async {
      await _isar.doctorVisits.delete(id);
    });
  }

  // -------------------------------------------------------
  // --- CHECKLIST ---
  // -------------------------------------------------------

  Future<void> toggleChecklistItem(Id id) async {
    await _safeWrite(() async {
      final item = await _isar.checklistItems.get(id);
      if (item != null) {
        item.isCompleted = !item.isCompleted;
        await _isar.checklistItems.put(item);
      }
    });
  }

  Stream<List<ChecklistItem>> watchChecklist(String category) {
    return _isar.checklistItems.filter().categoryEqualTo(category).watch(fireImmediately: true);
  }

  // -------------------------------------------------------
  // --- BABY NAMES ---
  // -------------------------------------------------------

  Future<void> voteName(Id id, NameVote vote) async {
    await _safeWrite(() async {
      final name = await _isar.babyNames.get(id);
      if (name != null) {
        name.vote = vote;
        await _isar.babyNames.put(name);
      }
    });
  }

  Stream<List<BabyName>> watchLikedNames() {
    return _isar.babyNames.filter().voteEqualTo(NameVote.liked).watch(fireImmediately: true);
  }

  // -------------------------------------------------------
  // --- BUMP GALLERY ---
  // -------------------------------------------------------

  Future<void> saveBumpPhoto(int week, String fileName) async {
    await _safeWrite(() async {
      final existing = await _isar.bumpSnapshots.filter().weekEqualTo(week).findFirst();
      if (existing != null) {
        existing.fileName = fileName;
        existing.date = DateTime.now();
        await _isar.bumpSnapshots.put(existing);
      } else {
        final newPhoto = BumpSnapshot(
            week: week,
            fileName: fileName,
            date: DateTime.now()
        );
        await _isar.bumpSnapshots.put(newPhoto);
      }
    });
  }

  Stream<List<BumpSnapshot>> watchBumpGallery() {
    return _isar.bumpSnapshots.where().sortByWeekDesc().watch(fireImmediately: true);
  }

  Future<void> deleteBumpPhoto(Id id) async {
    await _safeWrite(() async {
      await _isar.bumpSnapshots.delete(id);
    });
  }
}