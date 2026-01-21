import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pregnancy/domain/insight.dart';

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

  // 1. Метод для СФЕРЫ (Возвращаем именованный кортеж - Record)
  // Было: List<String> -> Стало: ({String title, String description})
  ({String title, String description}) getObjectData(int week, String languageCode, bool isFruitMode) {
    final dataMap = _dataRegistry[languageCode] ?? enInsightsData;

    if (dataMap.containsKey(week)) {
      final weekData = dataMap[week]!;

      // Выбираем ключ: 'fruit' или 'realistic'
      final modeKey = isFruitMode ? 'fruit' : 'realistic';
      // Если данных нет, берем другой режим как запасной
      final fallbackKey = isFruitMode ? 'realistic' : 'fruit';

      final obj = (weekData[modeKey] ?? weekData[fallbackKey]) as Map<String, String>;

      return (
      title: obj['title'] ?? "",
      description: obj['description'] ?? ""
      );
    }

    // Заглушка
    return languageCode == 'ru'
        ? (title: "Загрузка...", description: "Данные обновляются")
        : (title: "Loading...", description: "Updating data");
  }

  // 2. Метод для ЛЕНТЫ ИНСАЙТОВ
  List<Insight> getInsightsForWeek(int week, String languageCode) {
    final dataMap = _dataRegistry[languageCode] ?? enInsightsData;

    if (dataMap.containsKey(week)) {
      final weekData = dataMap[week]!;

      final rawInsights = weekData['insights'];
      // Проверка на null и тип
      if (rawInsights is! List) return [];

      return rawInsights.map((map) {
        // Приводим к Map
        final m = map as Map<String, dynamic>;

        return Insight(
          // Генерируем уникальный ID для списка
          id: "${week}_${m['title'].hashCode}",
          type: _parseType(m['type'] as String? ?? 'body'),
          title: m['title'] as String? ?? "",
          content: m['content'] as String? ?? "",
          // ВАЖНО: Передаем имя иконки строкой, UI сам превратит её в IconData
          iconName: m['icon'] as String? ?? 'info',
        );
      }).toList();
    }
    return [];
  }

  // --- ХЕЛПЕРЫ ---
  // Метод _getIcon удален, так как репозиторий больше не работает с UI (Flutter Material)

  InsightType _parseType(String type) {
    switch (type) {
      case 'body': return InsightType.body;
      case 'mind': return InsightType.mind;
      case 'action': return InsightType.action;
      case 'baby': return InsightType.baby;
      default: return InsightType.body;
    }
  }
}