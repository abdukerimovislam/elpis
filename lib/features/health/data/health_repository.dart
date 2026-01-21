import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // <--- ВОТ ЭТОГО НЕ ХВАТАЛО
import '../domain/health_record.dart';
import '../../../main.dart'; // Доступ к isarInstance

part 'health_repository.g.dart';

@riverpod
HealthRepository healthRepository(HealthRepositoryRef ref) {
  return HealthRepository(isarInstance);
}

class HealthRepository {
  final Isar _isar;

  HealthRepository(this._isar);

  // Получить запись за конкретный день (или создать пустую)
  Future<HealthRecord> getRecordForDate(DateTime date) async {
    // Округляем до начала дня
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final record = await _isar.healthRecords
        .filter()
        .dateGreaterThan(startOfDay, include: true)
        .and()
        .dateLessThan(endOfDay)
        .findFirst();

    if (record != null) return record;

    return HealthRecord(date: DateTime.now());
  }

  Future<void> addWaterGlass(DateTime date) async {
    await _isar.writeTxn(() async {
      final record = await _getOrCreateRecordInternal(date);
      record.waterGlasses += 1;
      await _isar.healthRecords.put(record);
    });
  }

  Future<void> removeWaterGlass(DateTime date) async {
    await _isar.writeTxn(() async {
      final record = await _getOrCreateRecordInternal(date);
      if (record.waterGlasses > 0) {
        record.waterGlasses -= 1;
        await _isar.healthRecords.put(record);
      }
    });
  }

  Future<void> saveKickSession({required DateTime date, required int kicks}) async {
    await _isar.writeTxn(() async {
      final record = await _getOrCreateRecordInternal(date);
      record.totalKicks += kicks;
      record.kickSessionsCount += 1;
      await _isar.healthRecords.put(record);
    });
  }

  Future<HealthRecord> _getOrCreateRecordInternal(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final existing = await _isar.healthRecords
        .filter()
        .dateGreaterThan(startOfDay, include: true)
        .and()
        .dateLessThan(endOfDay)
        .findFirst();

    if (existing != null) return existing;

    return HealthRecord(date: DateTime.now());
  }


  Future<void> saveWeight({required DateTime date, required double weight}) async {
    await _isar.writeTxn(() async {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      var existing = await _isar.healthRecords
          .filter()
          .dateGreaterThan(startOfDay, include: true)
          .and()
          .dateLessThan(endOfDay)
          .findFirst();

      if (existing != null) {
        existing.weightKg = weight;
        await _isar.healthRecords.put(existing);
      } else {
        final newRecord = HealthRecord(
          date: DateTime.now(),
          weightKg: weight,
          waterGlasses: 0,
        );
        await _isar.healthRecords.put(newRecord);
      }
    });
  }

  // Сохранить симптомы и настроение
  Future<void> saveSymptoms({
    required DateTime date,
    required List<String> symptoms,
    required int mood
  }) async {
    await _isar.writeTxn(() async {
      // Ищем запись за этот день
      final startOfDay = DateTime(date.year, date.month, date.day);
      final existing = await getRecordForDate(date);

      // Если запись новая (id autoIncrement), Isar создаст новую.
      // Если старая - обновит.

      // Важно: если запись была "виртуальной" (без ID), мы не можем просто обновить поля.
      // Нам нужно найти ее в БД или создать.

      HealthRecord recordToSave = existing;
      if (existing.id == Isar.autoIncrement) {
        // Это новая запись
        recordToSave = HealthRecord(
          date: DateTime.now(),
          symptoms: symptoms,
          moodRating: mood,
        );
      } else {
        // Обновляем существующую
        recordToSave.symptoms = symptoms;
        recordToSave.moodRating = mood;
      }

      await _isar.healthRecords.put(recordToSave);
    });
  }
}