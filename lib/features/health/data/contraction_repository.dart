import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/contraction.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

part 'contraction_repository.g.dart';

@Riverpod(keepAlive: true)
ContractionRepository contractionRepository(ContractionRepositoryRef ref) {
  return ContractionRepository(ref.watch(isarDatabaseProvider).valueOrNull);
}

class ContractionRepository {
  final Isar? _isar;

  ContractionRepository(this._isar);

  // 1. Начать новую схватку
  Future<Contraction> startContraction() async {
    if (_isar == null) {
      return Contraction(startTime: DateTime.now());
    }
    final contraction = Contraction(startTime: DateTime.now());
    await _isar.writeTxn(() async {
      // Закрываем все старые повисшие схватки перед началом новой
      final unclosed = await _isar.contractions.filter().endTimeIsNull().findAll();
      for (final old in unclosed) {
        old.endTime = DateTime.now(); // Принудительно закрываем
        await _isar.contractions.put(old);
      }
      await _isar.contractions.put(contraction);
    });
    return contraction;
  }

  // 2. Остановить текущую схватку
  Future<void> stopContraction(int id, {int intensity = 1}) async {
    if (_isar == null) {
      return;
    }
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
    if (_isar == null) {
      return null;
    }
    final active = await _isar.contractions
        .filter()
        .endTimeIsNull()
        .sortByStartTimeDesc()
        .findFirst();

    if (active != null) {
      // Если схватка длится больше 15 минут, это баг или забытый таймер. Отменяем.
      if (DateTime.now().difference(active.startTime).inMinutes > 15) {
        await stopContraction(active.id);
        return null; // Возвращаем пустоту, чтобы таймер не висел
      }
    }
    return active;
  }

  // 4. Получить историю (последние 50)
  Stream<List<Contraction>> watchHistory() {
    if (_isar == null) {
      return Stream.value(const []);
    }
    return _isar.contractions
        .where()
        .sortByStartTimeDesc()
        .limit(50)
        .watch(fireImmediately: true);
  }

  // 5. Очистить историю (новая сессия родов)
  Future<void> clearHistory() async {
    if (_isar == null) {
      return;
    }
    await _isar.writeTxn(() async {
      await _isar.contractions.clear();
    });
  }
}
