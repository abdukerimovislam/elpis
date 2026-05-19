import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/storage/app_database_schemas.dart';
import '../../family/domain/baby_name.dart';
import '../../family/domain/bump_snapshot.dart';
import '../../health/data/checklist_item.dart';
import '../../health/domain/contraction.dart';
import '../../health/domain/doctor_visit.dart';
import '../../health/domain/health_record.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../../pregnancy/domain/week_snapshot.dart';

final workspaceManagerProvider = Provider<WorkspaceManager>((ref) {
  return WorkspaceManager();
});

class WorkspaceManager {
  final Map<String, Future<Isar>> _workspaceCache = {};
  Future<Isar>? _legacyWorkspaceFuture;

  Future<String> workspaceDirectoryFor(String workspaceKey) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final workspaceDir =
        Directory(p.join(documentsDir.path, 'workspaces', workspaceKey));
    if (!await workspaceDir.exists()) {
      await workspaceDir.create(recursive: true);
    }
    return workspaceDir.path;
  }

  Future<String> legacyDirectoryPath() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    return documentsDir.path;
  }

  Future<Isar> openWorkspace(String workspaceKey) {
    return _workspaceCache.putIfAbsent(workspaceKey, () async {
      final directory = await workspaceDirectoryFor(workspaceKey);
      return Isar.open(
        appDatabaseSchemas,
        name: 'workspace_$workspaceKey',
        directory: directory,
        inspector: kDebugMode,
      );
    });
  }

  Future<Isar> openLegacyWorkspace() {
    return _legacyWorkspaceFuture ??= () async {
      final directory = await legacyDirectoryPath();
      return Isar.open(
        appDatabaseSchemas,
        name: 'legacy_workspace',
        directory: directory,
        inspector: kDebugMode,
      );
    }();
  }

  Future<void> closeLegacyWorkspace() async {
    final legacyFuture = _legacyWorkspaceFuture;
    if (legacyFuture == null) {
      return;
    }

    _legacyWorkspaceFuture = null;
    final legacy = await legacyFuture;
    await legacy.close();
  }

  Future<bool> legacyWorkspaceHasMeaningfulData() async {
    final legacy = await openLegacyWorkspace();
    return _isarHasMeaningfulData(legacy);
  }

  Future<bool> workspaceHasMeaningfulData(String workspaceKey) async {
    final workspace = await openWorkspace(workspaceKey);
    return _isarHasMeaningfulData(workspace);
  }

  Future<void> importLegacyWorkspaceInto(String targetWorkspaceKey) async {
    final legacy = await openLegacyWorkspace();
    final target = await openWorkspace(targetWorkspaceKey);
    await _replaceWorkspaceContents(
      source: legacy,
      sourceDirectory: await legacyDirectoryPath(),
      target: target,
      targetDirectory: await workspaceDirectoryFor(targetWorkspaceKey),
    );
  }

  Future<void> replaceWorkspaceData({
    required String sourceKey,
    required String targetKey,
  }) async {
    final source = await openWorkspace(sourceKey);
    final target = await openWorkspace(targetKey);
    await _replaceWorkspaceContents(
      source: source,
      sourceDirectory: await workspaceDirectoryFor(sourceKey),
      target: target,
      targetDirectory: await workspaceDirectoryFor(targetKey),
    );
  }

  Future<void> dispose() async {
    for (final future in _workspaceCache.values) {
      final isar = await future;
      await isar.close();
    }
    _workspaceCache.clear();
    await closeLegacyWorkspace();
  }

  Future<bool> _isarHasMeaningfulData(Isar isar) async {
    if (await isar.pregnancySettings.count() > 0) {
      return true;
    }
    if (await isar.weekSnapshots.count() > 0) {
      return true;
    }
    if (await isar.healthRecords.count() > 0) {
      return true;
    }
    if (await isar.contractions.count() > 0) {
      return true;
    }
    if (await isar.doctorVisits.count() > 0) {
      return true;
    }
    if (await isar.bumpSnapshots.count() > 0) {
      return true;
    }
    if (await isar.checklistItems.filter().isCompletedEqualTo(true).count() > 0) {
      return true;
    }
    if (await isar.babyNames
            .filter()
            .anyOf(
              [NameVote.liked, NameVote.disliked],
              (query, vote) => query.voteEqualTo(vote),
            )
            .count() >
        0) {
      return true;
    }
    return false;
  }

  Future<void> _replaceWorkspaceContents({
    required Isar source,
    required String sourceDirectory,
    required Isar target,
    required String targetDirectory,
  }) async {
    final sourceSettings = await source.pregnancySettings.where().findAll();
    final sourceSnapshots = await source.weekSnapshots.where().findAll();
    final sourceHealthRecords = await source.healthRecords.where().findAll();
    final sourceContractions = await source.contractions.where().findAll();
    final sourceChecklistItems = await source.checklistItems.where().findAll();
    final sourceVisits = await source.doctorVisits.where().findAll();
    final sourceBabyNames = await source.babyNames.where().findAll();
    final sourceBumpSnapshots = await source.bumpSnapshots.where().findAll();
    final existingTargetBumpSnapshots = await target.bumpSnapshots.where().findAll();

    for (final snapshot in existingTargetBumpSnapshots) {
      final file = File(p.join(targetDirectory, snapshot.fileName));
      if (await file.exists()) {
        await file.delete();
      }
    }

    await target.writeTxn(() async {
      await target.clear();
      await target.pregnancySettings.putAll(
        sourceSettings.map(_clonePregnancySettings).toList(),
      );
      await target.weekSnapshots.putAll(
        sourceSnapshots.map(_cloneWeekSnapshot).toList(),
      );
      await target.healthRecords.putAll(
        sourceHealthRecords.map(_cloneHealthRecord).toList(),
      );
      await target.contractions.putAll(
        sourceContractions.map(_cloneContraction).toList(),
      );
      await target.checklistItems.putAll(
        sourceChecklistItems.map(_cloneChecklistItem).toList(),
      );
      await target.doctorVisits.putAll(
        sourceVisits.map(_cloneDoctorVisit).toList(),
      );
      await target.babyNames.putAll(
        sourceBabyNames.map(_cloneBabyName).toList(),
      );
      await target.bumpSnapshots.putAll(
        sourceBumpSnapshots.map(_cloneBumpSnapshot).toList(),
      );
    });

    for (final bumpSnapshot in sourceBumpSnapshots) {
      final sourceFile = File(p.join(sourceDirectory, bumpSnapshot.fileName));
      if (!await sourceFile.exists()) {
        continue;
      }

      final copiedFile = File(p.join(targetDirectory, bumpSnapshot.fileName));
      await copiedFile.parent.create(recursive: true);
      await sourceFile.copy(copiedFile.path);
    }
  }

  PregnancySettings _clonePregnancySettings(PregnancySettings source) {
    return source.copyWith();
  }

  WeekSnapshot _cloneWeekSnapshot(WeekSnapshot source) {
    return WeekSnapshot(
      id: source.id,
      week: source.week,
      weightKg: source.weightKg,
      bellyGirthCm: source.bellyGirthCm,
      notes: source.notes,
      letterToBaby: source.letterToBaby,
      photoPaths:
          source.photoPaths == null ? null : List<String>.from(source.photoPaths!),
      date: source.date,
    );
  }

  HealthRecord _cloneHealthRecord(HealthRecord source) {
    return HealthRecord(
      id: source.id,
      date: source.date,
      moodRating: source.moodRating,
      weightKg: source.weightKg,
      symptoms:
          source.symptoms == null ? null : List<String>.from(source.symptoms!),
      waterGlasses: source.waterGlasses,
      note: source.note,
      totalKicks: source.totalKicks,
      kickSessionsCount: source.kickSessionsCount,
    );
  }

  Contraction _cloneContraction(Contraction source) {
    return Contraction(
      id: source.id,
      startTime: source.startTime,
      endTime: source.endTime,
      intensity: source.intensity,
    );
  }

  ChecklistItem _cloneChecklistItem(ChecklistItem source) {
    return ChecklistItem(
      id: source.id,
      title: source.title,
      category: source.category,
      isCompleted: source.isCompleted,
    );
  }

  DoctorVisit _cloneDoctorVisit(DoctorVisit source) {
    return DoctorVisit(
      id: source.id,
      date: source.date,
      title: source.title,
      doctorName: source.doctorName,
      questionsToAsk: source.questionsToAsk,
      weightKg: source.weightKg,
      bpSystolic: source.bpSystolic,
      bpDiastolic: source.bpDiastolic,
      doctorNotes: source.doctorNotes,
      isCompleted: source.isCompleted,
    );
  }

  BabyName _cloneBabyName(BabyName source) {
    return BabyName(
      id: source.id,
      name: source.name,
      meaning: source.meaning,
      origin: source.origin,
      nationality: source.nationality,
      gender: source.gender,
      language: source.language,
      script: source.script,
      era: source.era,
      notes: source.notes,
      vote: source.vote,
    );
  }

  BumpSnapshot _cloneBumpSnapshot(BumpSnapshot source) {
    return BumpSnapshot(
      id: source.id,
      week: source.week,
      fileName: source.fileName,
      date: source.date,
    );
  }
}
