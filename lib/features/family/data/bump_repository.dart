import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/bump_snapshot.dart';
import '../../../main.dart';

// ИСПРАВЛЕНО: имя файла совпадает с именем этого файла
part 'bump_repository.g.dart';

@Riverpod(keepAlive: true)
BumpRepository bumpRepository(BumpRepositoryRef ref) {
  return BumpRepository(isarInstance);
}

class BumpRepository {
  final Isar _isar;

  BumpRepository(this._isar);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Stream<List<BumpSnapshot>> watchSnapshots() async* {
    final path = await _localPath;
    yield* _isar.bumpSnapshots
        .where()
        .sortByWeekDesc()
        .watch(fireImmediately: true)
        .map((snapshots) {
      return snapshots.map((s) {
        s.tempFullFilePath = p.join(path, s.fileName);
        return s;
      }).toList();
    });
  }

  Future<void> savePhoto(int week, String tempPath) async {
    final path = await _localPath;
    final extension = p.extension(tempPath);
    final fileName = 'bump_week_$week\_${DateTime.now().millisecondsSinceEpoch}$extension';
    final permanentPath = p.join(path, fileName);

    await File(tempPath).copy(permanentPath);

    await _isar.writeTxn(() async {
      await _isar.bumpSnapshots.put(BumpSnapshot(
        week: week,
        fileName: fileName,
        date: DateTime.now(),
      ));
    });
  }

  Future<void> deletePhoto(int id) async {
    final path = await _localPath;
    await _isar.writeTxn(() async {
      final photo = await _isar.bumpSnapshots.get(id);
      if (photo != null) {
        final file = File(p.join(path, photo.fileName));
        if (await file.exists()) await file.delete();
        await _isar.bumpSnapshots.delete(id);
      }
    });
  }
}