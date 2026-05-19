import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/bump_snapshot.dart';
// ИСПРАВЛЕНО: Теперь берем базу безопасно через провайдер, а не из main.dart
import '../../auth/data/auth_session_repository.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

part 'bump_repository.g.dart';

@Riverpod(keepAlive: true)
BumpRepository bumpRepository(BumpRepositoryRef ref) {
  // ИСПРАВЛЕНО: Безопасное получение инстанса Isar
  return BumpRepository(
    ref.watch(isarDatabaseProvider).valueOrNull,
    ref.watch(activeWorkspaceDirectoryProvider).valueOrNull,
  );
}

class BumpRepository {
  final Isar? _isar;
  final String? _workspaceDirectory;

  BumpRepository(this._isar, this._workspaceDirectory);

  Stream<List<BumpSnapshot>> watchSnapshots() async* {
    if (_isar == null || _workspaceDirectory == null) {
      yield [];
      return;
    }

      yield* _isar.bumpSnapshots
        .where()
        .sortByWeekDesc()
        .watch(fireImmediately: true)
        .map((snapshots) {
      return snapshots.map((s) {
        s.tempFullFilePath = p.join(_workspaceDirectory, s.fileName);
        return s;
      }).toList();
    });
  }

  Future<void> savePhoto(int week, String tempPath) async {
    if (_isar == null || _workspaceDirectory == null) return;

    final extension = p.extension(tempPath);
    final fileName =
        'bump_week_${week}_${DateTime.now().millisecondsSinceEpoch}$extension';
    final permanentPath = p.join(_workspaceDirectory, fileName);

    await File(tempPath).copy(permanentPath);

    await _isar.writeTxn(() async {
      final existing =
      await _isar.bumpSnapshots.filter().weekEqualTo(week).findFirst();

      if (existing != null) {
        final oldFile = File(p.join(_workspaceDirectory, existing.fileName));
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
        existing.fileName = fileName;
        existing.date = DateTime.now();
        await _isar.bumpSnapshots.put(existing);
        return;
      }

      await _isar.bumpSnapshots.put(BumpSnapshot(
        week: week,
        fileName: fileName,
        date: DateTime.now(),
      ));
    });
  }

  Future<void> deletePhoto(int id) async {
    if (_isar == null || _workspaceDirectory == null) return;

    await _isar.writeTxn(() async {
      final photo = await _isar.bumpSnapshots.get(id);
      if (photo != null) {
        final file = File(p.join(_workspaceDirectory, photo.fileName));
        if (await file.exists()) await file.delete();
        await _isar.bumpSnapshots.delete(id);
      }
    });
  }
}
