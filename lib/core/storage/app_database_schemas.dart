import 'package:isar/isar.dart';

import '../../features/family/domain/baby_name.dart';
import '../../features/family/domain/bump_snapshot.dart';
import '../../features/health/data/checklist_item.dart';
import '../../features/health/domain/contraction.dart';
import '../../features/health/domain/doctor_visit.dart';
import '../../features/health/domain/health_record.dart';
import '../../features/pregnancy/domain/pregnancy_settings.dart';
import '../../features/pregnancy/domain/week_snapshot.dart';

const List<CollectionSchema<dynamic>> appDatabaseSchemas = [
  WeekSnapshotSchema,
  PregnancySettingsSchema,
  HealthRecordSchema,
  ContractionSchema,
  ChecklistItemSchema,
  DoctorVisitSchema,
  BabyNameSchema,
  BumpSnapshotSchema,
];
