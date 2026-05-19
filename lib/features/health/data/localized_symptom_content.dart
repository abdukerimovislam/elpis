import '../../../l10n/app_localizations.dart';

class SymptomKeyDefinition {
  final String id;
  final String titleKey;
  final String shortDescriptionKey;
  final String fullDescriptionKey;
  final String severityName;
  final List<int> trimesters;

  const SymptomKeyDefinition({
    required this.id,
    required this.titleKey,
    required this.shortDescriptionKey,
    required this.fullDescriptionKey,
    required this.severityName,
    required this.trimesters,
  });
}

final List<SymptomKeyDefinition> symptomKeyDefinitions = [
  const SymptomKeyDefinition(
    id: '1',
    titleKey: 'symptom1Title',
    shortDescriptionKey: 'symptom1ShortDescription',
    fullDescriptionKey: 'symptom1FullDescription',
    severityName: 'common',
    trimesters: [1],
  ),
  const SymptomKeyDefinition(
    id: '2',
    titleKey: 'symptom2Title',
    shortDescriptionKey: 'symptom2ShortDescription',
    fullDescriptionKey: 'symptom2FullDescription',
    severityName: 'common',
    trimesters: [2],
  ),
  const SymptomKeyDefinition(
    id: '3',
    titleKey: 'symptom3Title',
    shortDescriptionKey: 'symptom3ShortDescription',
    fullDescriptionKey: 'symptom3FullDescription',
    severityName: 'urgent',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '4',
    titleKey: 'symptom4Title',
    shortDescriptionKey: 'symptom4ShortDescription',
    fullDescriptionKey: 'symptom4FullDescription',
    severityName: 'monitor',
    trimesters: [3],
  ),
  const SymptomKeyDefinition(
    id: '5',
    titleKey: 'symptom5Title',
    shortDescriptionKey: 'symptom5ShortDescription',
    fullDescriptionKey: 'symptom5FullDescription',
    severityName: 'monitor',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '6',
    titleKey: 'symptom6Title',
    shortDescriptionKey: 'symptom6ShortDescription',
    fullDescriptionKey: 'symptom6FullDescription',
    severityName: 'common',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '7',
    titleKey: 'symptom7Title',
    shortDescriptionKey: 'symptom7ShortDescription',
    fullDescriptionKey: 'symptom7FullDescription',
    severityName: 'common',
    trimesters: [1, 3],
  ),
  const SymptomKeyDefinition(
    id: '8',
    titleKey: 'symptom8Title',
    shortDescriptionKey: 'symptom8ShortDescription',
    fullDescriptionKey: 'symptom8FullDescription',
    severityName: 'common',
    trimesters: [1],
  ),
  const SymptomKeyDefinition(
    id: '9',
    titleKey: 'symptom9Title',
    shortDescriptionKey: 'symptom9ShortDescription',
    fullDescriptionKey: 'symptom9FullDescription',
    severityName: 'common',
    trimesters: [1, 3],
  ),
  const SymptomKeyDefinition(
    id: '10',
    titleKey: 'symptom10Title',
    shortDescriptionKey: 'symptom10ShortDescription',
    fullDescriptionKey: 'symptom10FullDescription',
    severityName: 'common',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '11',
    titleKey: 'symptom11Title',
    shortDescriptionKey: 'symptom11ShortDescription',
    fullDescriptionKey: 'symptom11FullDescription',
    severityName: 'common',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '12',
    titleKey: 'symptom12Title',
    shortDescriptionKey: 'symptom12ShortDescription',
    fullDescriptionKey: 'symptom12FullDescription',
    severityName: 'monitor',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '13',
    titleKey: 'symptom13Title',
    shortDescriptionKey: 'symptom13ShortDescription',
    fullDescriptionKey: 'symptom13FullDescription',
    severityName: 'common',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '14',
    titleKey: 'symptom14Title',
    shortDescriptionKey: 'symptom14ShortDescription',
    fullDescriptionKey: 'symptom14FullDescription',
    severityName: 'common',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '15',
    titleKey: 'symptom15Title',
    shortDescriptionKey: 'symptom15ShortDescription',
    fullDescriptionKey: 'symptom15FullDescription',
    severityName: 'monitor',
    trimesters: [1, 2],
  ),
  const SymptomKeyDefinition(
    id: '16',
    titleKey: 'symptom16Title',
    shortDescriptionKey: 'symptom16ShortDescription',
    fullDescriptionKey: 'symptom16FullDescription',
    severityName: 'common',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '17',
    titleKey: 'symptom17Title',
    shortDescriptionKey: 'symptom17ShortDescription',
    fullDescriptionKey: 'symptom17FullDescription',
    severityName: 'common',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '18',
    titleKey: 'symptom18Title',
    shortDescriptionKey: 'symptom18ShortDescription',
    fullDescriptionKey: 'symptom18FullDescription',
    severityName: 'common',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '19',
    titleKey: 'symptom19Title',
    shortDescriptionKey: 'symptom19ShortDescription',
    fullDescriptionKey: 'symptom19FullDescription',
    severityName: 'monitor',
    trimesters: [3],
  ),
  const SymptomKeyDefinition(
    id: '20',
    titleKey: 'symptom20Title',
    shortDescriptionKey: 'symptom20ShortDescription',
    fullDescriptionKey: 'symptom20FullDescription',
    severityName: 'monitor',
    trimesters: [2, 3],
  ),
  const SymptomKeyDefinition(
    id: '21',
    titleKey: 'symptom21Title',
    shortDescriptionKey: 'symptom21ShortDescription',
    fullDescriptionKey: 'symptom21FullDescription',
    severityName: 'urgent',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '22',
    titleKey: 'symptom22Title',
    shortDescriptionKey: 'symptom22ShortDescription',
    fullDescriptionKey: 'symptom22FullDescription',
    severityName: 'urgent',
    trimesters: [1, 2, 3],
  ),
  const SymptomKeyDefinition(
    id: '23',
    titleKey: 'symptom23Title',
    shortDescriptionKey: 'symptom23ShortDescription',
    fullDescriptionKey: 'symptom23FullDescription',
    severityName: 'urgent',
    trimesters: [3],
  ),
];

String resolveSymptomText(AppLocalizations l10n, String key) {
  switch (key) {
    case 'symptom1Title':
      return l10n.symptom1Title;
    case 'symptom1ShortDescription':
      return l10n.symptom1ShortDescription;
    case 'symptom1FullDescription':
      return l10n.symptom1FullDescription;
    case 'symptom2Title':
      return l10n.symptom2Title;
    case 'symptom2ShortDescription':
      return l10n.symptom2ShortDescription;
    case 'symptom2FullDescription':
      return l10n.symptom2FullDescription;
    case 'symptom3Title':
      return l10n.symptom3Title;
    case 'symptom3ShortDescription':
      return l10n.symptom3ShortDescription;
    case 'symptom3FullDescription':
      return l10n.symptom3FullDescription;
    case 'symptom4Title':
      return l10n.symptom4Title;
    case 'symptom4ShortDescription':
      return l10n.symptom4ShortDescription;
    case 'symptom4FullDescription':
      return l10n.symptom4FullDescription;
    case 'symptom5Title':
      return l10n.symptom5Title;
    case 'symptom5ShortDescription':
      return l10n.symptom5ShortDescription;
    case 'symptom5FullDescription':
      return l10n.symptom5FullDescription;
    case 'symptom6Title':
      return l10n.symptom6Title;
    case 'symptom6ShortDescription':
      return l10n.symptom6ShortDescription;
    case 'symptom6FullDescription':
      return l10n.symptom6FullDescription;
    case 'symptom7Title':
      return l10n.symptom7Title;
    case 'symptom7ShortDescription':
      return l10n.symptom7ShortDescription;
    case 'symptom7FullDescription':
      return l10n.symptom7FullDescription;
    case 'symptom8Title':
      return l10n.symptom8Title;
    case 'symptom8ShortDescription':
      return l10n.symptom8ShortDescription;
    case 'symptom8FullDescription':
      return l10n.symptom8FullDescription;
    case 'symptom9Title':
      return l10n.symptom9Title;
    case 'symptom9ShortDescription':
      return l10n.symptom9ShortDescription;
    case 'symptom9FullDescription':
      return l10n.symptom9FullDescription;
    case 'symptom10Title':
      return l10n.symptom10Title;
    case 'symptom10ShortDescription':
      return l10n.symptom10ShortDescription;
    case 'symptom10FullDescription':
      return l10n.symptom10FullDescription;
    case 'symptom11Title':
      return l10n.symptom11Title;
    case 'symptom11ShortDescription':
      return l10n.symptom11ShortDescription;
    case 'symptom11FullDescription':
      return l10n.symptom11FullDescription;
    case 'symptom12Title':
      return l10n.symptom12Title;
    case 'symptom12ShortDescription':
      return l10n.symptom12ShortDescription;
    case 'symptom12FullDescription':
      return l10n.symptom12FullDescription;
    case 'symptom13Title':
      return l10n.symptom13Title;
    case 'symptom13ShortDescription':
      return l10n.symptom13ShortDescription;
    case 'symptom13FullDescription':
      return l10n.symptom13FullDescription;
    case 'symptom14Title':
      return l10n.symptom14Title;
    case 'symptom14ShortDescription':
      return l10n.symptom14ShortDescription;
    case 'symptom14FullDescription':
      return l10n.symptom14FullDescription;
    case 'symptom15Title':
      return l10n.symptom15Title;
    case 'symptom15ShortDescription':
      return l10n.symptom15ShortDescription;
    case 'symptom15FullDescription':
      return l10n.symptom15FullDescription;
    case 'symptom16Title':
      return l10n.symptom16Title;
    case 'symptom16ShortDescription':
      return l10n.symptom16ShortDescription;
    case 'symptom16FullDescription':
      return l10n.symptom16FullDescription;
    case 'symptom17Title':
      return l10n.symptom17Title;
    case 'symptom17ShortDescription':
      return l10n.symptom17ShortDescription;
    case 'symptom17FullDescription':
      return l10n.symptom17FullDescription;
    case 'symptom18Title':
      return l10n.symptom18Title;
    case 'symptom18ShortDescription':
      return l10n.symptom18ShortDescription;
    case 'symptom18FullDescription':
      return l10n.symptom18FullDescription;
    case 'symptom19Title':
      return l10n.symptom19Title;
    case 'symptom19ShortDescription':
      return l10n.symptom19ShortDescription;
    case 'symptom19FullDescription':
      return l10n.symptom19FullDescription;
    case 'symptom20Title':
      return l10n.symptom20Title;
    case 'symptom20ShortDescription':
      return l10n.symptom20ShortDescription;
    case 'symptom20FullDescription':
      return l10n.symptom20FullDescription;
    case 'symptom21Title':
      return l10n.symptom21Title;
    case 'symptom21ShortDescription':
      return l10n.symptom21ShortDescription;
    case 'symptom21FullDescription':
      return l10n.symptom21FullDescription;
    case 'symptom22Title':
      return l10n.symptom22Title;
    case 'symptom22ShortDescription':
      return l10n.symptom22ShortDescription;
    case 'symptom22FullDescription':
      return l10n.symptom22FullDescription;
    case 'symptom23Title':
      return l10n.symptom23Title;
    case 'symptom23ShortDescription':
      return l10n.symptom23ShortDescription;
    case 'symptom23FullDescription':
      return l10n.symptom23FullDescription;
    default:
      return '';
  }
}
