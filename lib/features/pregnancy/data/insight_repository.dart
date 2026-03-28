import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pregnancy/domain/insight.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';

// ИМПОРТЫ ДАННЫХ
import 'locales/ru_insights.dart';
import 'locales/en_insights.dart';

part 'insight_repository.g.dart';

@Riverpod(keepAlive: true)
InsightRepository insightRepository(InsightRepositoryRef ref) {
  return InsightRepository();
}

class InsightRepository {
  static const Map<String, Map<int, Map<String, dynamic>>> _dataRegistry = {
    'ru': ruInsightsData,
    'en': enInsightsData,
  };

  // 🔥 ЭКСКЛЮЗИВНЫЕ ДАННЫЕ ДЛЯ РАННИХ НЕДЕЛЬ (Зашиты в код)
  static const Map<String, Map<int, Map<String, String>>> _earlyWeeksData = {
    'ru': {
      1: {
        'title': 'Начало цикла',
        'description': 'Ваш организм готовится к возможному чуду.'
      },
      2: {
        'title': 'Овуляция',
        'description': 'Самый важный момент для зарождения новой жизни.'
      },
      3: {
        'title': 'Зачатие',
        'description': 'Маленькая клетка начинает свое большое путешествие.'
      },
    },
    'en': {
      1: {
        'title': 'Cycle Start',
        'description': 'Your body is preparing for a possible miracle.'
      },
      2: {
        'title': 'Ovulation',
        'description': 'The crucial moment for creating new life.'
      },
      3: {
        'title': 'Conception',
        'description': 'A tiny cell begins its big journey.'
      },
    }
  };

  String _normalizeLocale(String code) {
    if (code.contains('_')) return code.split('_')[0].toLowerCase();
    if (code.contains('-')) return code.split('-')[0].toLowerCase();
    return code.toLowerCase();
  }

  // Хелпер: Картинки берем от 4-й недели, если срок меньше
  // 1. Метод для СФЕРЫ (Заголовки и описания)
  ({String title, String description}) getObjectData(
      int week, String languageCode, String visualModeKey) {
    final normalizedLang = _normalizeLocale(languageCode);

    // --- ЛОГИКА 1: РАННИЕ НЕДЕЛИ (1-3) ---
    if (week < 4) {
      // Пытаемся найти специальный текст для 1-3 недели
      final specificData = _earlyWeeksData[normalizedLang]?[week] ??
          _earlyWeeksData['en']?[week];

      if (specificData != null) {
        return (
          title: specificData['title']!,
          description: specificData['description']!
        );
      }
    }

    // --- ЛОГИКА 2: ОБЫЧНЫЕ НЕДЕЛИ (4-42) ---
    final dataMap = _dataRegistry[normalizedLang] ?? enInsightsData;

    // Для 41-42 недели берем данные 40-й
    final safeWeek = week > 40 ? 40 : week;

    if (dataMap.containsKey(safeWeek)) {
      final weekData = dataMap[safeWeek]!;

      final useFruit = visualModeKey == PregnancySettings.visualModeFruit;
      final modeKey = useFruit ? 'fruit' : 'realistic';
      final fallbackKey = useFruit ? 'realistic' : 'fruit';

      final obj =
          (weekData[modeKey] ?? weekData[fallbackKey]) as Map<String, String>;

      return (title: obj['title'] ?? "", description: obj['description'] ?? "");
    }

    // Заглушка, если ничего не нашлось
    return normalizedLang == 'ru'
        ? (title: "Загрузка...", description: "Данные обновляются")
        : (title: "Loading...", description: "Updating data");
  }

  // 2. Метод для ЛЕНТЫ ИНСАЙТОВ
  List<Insight> getInsightsForWeek(int week, String languageCode) {
    final normalizedLang = _normalizeLocale(languageCode);
    final dataMap = _dataRegistry[normalizedLang] ?? enInsightsData;

    // Для 1-3 недели можем показывать инсайты от 4-й (общие советы про витамины)
    // Или возвращать пустой список, если не хотим путать маму.
    // Решение: Берем от 4-й, так как там про фолиевую кислоту - это актуально всегда.
    final safeWeek = week < 4 ? 4 : (week > 40 ? 40 : week);

    if (dataMap.containsKey(safeWeek)) {
      final weekData = dataMap[safeWeek]!;

      final rawInsights = weekData['insights'];
      if (rawInsights is! List) return [];

      return rawInsights.map((map) {
        final m = map as Map<String, dynamic>;
        return Insight(
          id: "${week}_${m['title'].hashCode}",
          type: _parseType(m['type'] as String? ?? 'body'),
          title: m['title'] as String? ?? "",
          content: m['content'] as String? ?? "",
          iconName: m['icon'] as String? ?? 'info',
        );
      }).toList();
    }
    return [];
  }

  InsightType _parseType(String type) {
    switch (type) {
      case 'body':
        return InsightType.body;
      case 'mind':
        return InsightType.mind;
      case 'action':
        return InsightType.action;
      case 'baby':
        return InsightType.baby;
      default:
        return InsightType.body;
    }
  }
}
