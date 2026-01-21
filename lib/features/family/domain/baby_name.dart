import 'package:isar/isar.dart';

part 'baby_name.g.dart';

enum NameGender { boy, girl, unisex }
enum NameVote { none, liked, disliked }

@collection
class BabyName {
  Id id;

  // УЛУЧШЕНИЕ: поиск без учета регистра для удобства поиска в админке или поиске
  @Index(caseSensitive: false)
  String name;

  String meaning;
  String origin;

  // УЛУЧШЕНИЕ: индекс для быстрой фильтрации по странам в свайпере
  @Index()
  String nationality;

  @Enumerated(EnumType.ordinal)
  NameGender gender;

  // Дополнительные данные
  String? language;
  String? script;
  String? era;
  String? notes;

  // Статус свайпа
  @Enumerated(EnumType.ordinal)
  @Index() // Добавили индекс, чтобы мгновенно получать список "Liked"
  NameVote vote;

  BabyName({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.meaning,
    required this.origin,
    required this.nationality,
    required this.gender,
    this.language,
    this.script,
    this.era,
    this.notes,
    this.vote = NameVote.none,
  });
}