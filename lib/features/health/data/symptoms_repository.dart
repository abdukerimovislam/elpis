import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import 'localized_symptom_content.dart';

enum SymptomSeverity {
  common,
  monitor,
  urgent,
}

class Symptom {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final SymptomSeverity severity;
  final List<int> trimesters;

  const Symptom({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.severity,
    required this.trimesters,
  });
}

final symptomsRepositoryProvider =
    Provider<SymptomsRepository>((ref) => SymptomsRepository());

class SymptomsRepository {
  List<Symptom> search(String query, AppLocalizations l10n) {
    final list = symptomKeyDefinitions.map((definition) {
      return Symptom(
        id: definition.id,
        title: resolveSymptomText(l10n, definition.titleKey),
        shortDescription:
            resolveSymptomText(l10n, definition.shortDescriptionKey),
        fullDescription:
            resolveSymptomText(l10n, definition.fullDescriptionKey),
        severity: _parseSeverity(definition.severityName),
        trimesters: definition.trimesters,
      );
    }).toList();

    if (query.isEmpty) {
      return list;
    }

    final normalized = query.toLowerCase();
    return list
        .where((symptom) =>
            symptom.title.toLowerCase().contains(normalized) ||
            symptom.shortDescription.toLowerCase().contains(normalized))
        .toList();
  }

  SymptomSeverity _parseSeverity(String value) {
    switch (value) {
      case 'common':
        return SymptomSeverity.common;
      case 'monitor':
        return SymptomSeverity.monitor;
      case 'urgent':
        return SymptomSeverity.urgent;
      default:
        return SymptomSeverity.common;
    }
  }
}
