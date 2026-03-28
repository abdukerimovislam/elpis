import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/contraction.dart';
import '../../../main.dart'; // Доступ к isarInstance

part 'contraction_repository.g.dart';

@Riverpod(keepAlive: true)
ContractionRepository contractionRepository(ContractionRepositoryRef ref) {
  return ContractionRepository(isarInstance);
}

class ContractionRepository {
  final Isar _isar;

  ContractionRepository(this._isar);

  // 1. Начать новую схватку
  Future<Contraction> startContraction() async {
    final contraction = Contraction(startTime: DateTime.now());
    await _isar.writeTxn(() async {
      await _isar.contractions.put(contraction);
    });
    return contraction;
  }

  // 2. Остановить текущую схватку
  Future<void> stopContraction(int id, {int intensity = 1}) async {
    await _isar.writeTxn(() async {
      final contraction = await _isar.contractions.get(id);
      if (contraction != null) {
        contraction.endTime = DateTime.now();
        contraction.intensity = intensity;
        await _isar.contractions.put(contraction);
      }
    });
  }

  // 3. Получить активную схватку (если вдруг приложение закрылось)
  Future<Contraction?> getActiveContraction() async {
    return await _isar.contractions
        .filter()
        .endTimeIsNull()
        .sortByStartTimeDesc()
        .findFirst();
  }

  // 4. Получить историю (последние 50)
  Stream<List<Contraction>> watchHistory() {
    return _isar.contractions
        .where()
        .sortByStartTimeDesc()
        .limit(50)
        .watch(fireImmediately: true);
  }

  // 5. Очистить историю (новая сессия родов)
  Future<void> clearHistory() async {
    await _isar.writeTxn(() async {
      await _isar.contractions.clear();
    });
  }
}
