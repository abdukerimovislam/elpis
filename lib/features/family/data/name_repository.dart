import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/baby_name.dart';
import '../../pregnancy/data/pregnancy_repository.dart'; // Используем наш основной провайдер БД

part 'name_repository.g.dart';

@Riverpod(keepAlive: true)
NameRepository nameRepository(NameRepositoryRef ref) {
  final isarAsync = ref.watch(isarDatabaseProvider);
  if (isarAsync.isLoading || isarAsync.hasError) {
    throw UnimplementedError('Database not ready');
  }
  return NameRepository(isarAsync.requireValue);
}

class NameRepository {
  final Isar _isar;

  NameRepository(this._isar);

  // 1. ПОЛУЧЕНИЕ ИМЕН С ФИЛЬТРАМИ
  Future<List<BabyName>> getNamesToSwipe({
    NameGender? gender,
    List<String>? nationalities,
  }) async {
    var query = _isar.babyNames.filter().voteEqualTo(NameVote.none);

    if (gender != null) {
      query = query.genderEqualTo(gender);
    }

    if (nationalities != null && nationalities.isNotEmpty) {
      query = query.anyOf(nationalities, (q, nation) => q.nationalityEqualTo(nation));
    }

    // Лимит 50 имен за раз для производительности UI
    final rawList = await query.limit(50).findAll();
    rawList.shuffle();
    return rawList;
  }

  // 2. ИЗБРАННОЕ (Стрим для UI)
  Stream<List<BabyName>> watchLikedNames() {
    return _isar.babyNames
        .filter()
        .voteEqualTo(NameVote.liked)
        .watch(fireImmediately: true);
  }

  // 3. ГОЛОСОВАНИЕ
  Future<void> voteName(int id, NameVote vote) async {
    try {
      await _isar.writeTxn(() async {
        final item = await _isar.babyNames.get(id);
        if (item != null) {
          item.vote = vote;
          await _isar.babyNames.put(item);
        }
      });
    } catch (e) {
      debugPrint("Vote Error: $e");
    }
  }

  // 4. СПИСОК ДОСТУПНЫХ СТРАН (Уникальные значения из БД)
  Future<List<String>> getAvailableNationalities() async {
    final list = await _isar.babyNames.where().distinctByNationality().findAll();

    return list
        .map((e) => e.nationality)
        .where((code) => code.toLowerCase() != 'nationality' && code.length == 2)
        .toList();
  }

  // 5. ИНИЦИАЛИЗАЦИЯ (ОПТИМИЗИРОВАННЫЙ ИМПОРТ)
  Future<void> ensureInitialized() async {
    final count = await _isar.babyNames.count();

    if (count == 0) {
      try {
        debugPrint("📥 Начало импорта имен из CSV...");
        final csvString = await rootBundle.loadString('assets/names.csv');

        // Используем более надежный парсер
        List<List<dynamic>> rows = const CsvToListConverter(
          eol: '\n',
          fieldDelimiter: ',',
          shouldParseNumbers: false, // Нам все нужно как строки
        ).convert(csvString);

        if (rows.isEmpty) return;

        // Пропускаем заголовок
        if (rows[0][0].toString().toLowerCase().contains('name')) {
          rows.removeAt(0);
        }

        // РАЗБИВАЕМ НА ЧАНКИ (по 500 имен), чтобы не забить память
        const int chunkSize = 500;
        for (var i = 0; i < rows.length; i += chunkSize) {
          final chunk = rows.sublist(i, i + chunkSize > rows.length ? rows.length : i + chunkSize);

          final namesToInsert = chunk.map((row) {
            return BabyName(
              name: row[0].toString().trim(),
              meaning: row[1].toString().trim(),
              origin: row[2].toString().trim(),
              gender: _parseGender(row[3].toString().trim()),
              nationality: row[4].toString().trim().toLowerCase(),
              language: _getVal(row, 5),
              script:   _getVal(row, 6),
              era:      _getVal(row, 7),
              notes:    _getVal(row, 8),
              vote: NameVote.none,
            );
          }).toList();

          await _isar.writeTxn(() async {
            await _isar.babyNames.putAll(namesToInsert);
          });

          debugPrint("✅ Загружено ${i + namesToInsert.length} / ${rows.length}");
        }

        debugPrint("🎉 Импорт полностью завершен.");

      } catch (e) {
        debugPrint("❌ Критическая ошибка импорта: $e");
      }
    }
  }

  String? _getVal(List<dynamic> row, int index) {
    if (index >= row.length) return null;
    final val = row[index].toString().trim();
    return val.isEmpty ? null : val;
  }

  NameGender _parseGender(String g) {
    final val = g.toLowerCase();
    if (val.contains('boy') || val == 'm') return NameGender.boy;
    if (val.contains('girl') || val == 'f') return NameGender.girl;
    return NameGender.unisex;
  }
}