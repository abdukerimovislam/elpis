import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/domain/insight.dart';
import 'localized_insight_content.dart';

part 'insight_repository.g.dart';

@Riverpod(keepAlive: true)
InsightRepository insightRepository(InsightRepositoryRef ref) {
  return InsightRepository();
}

class InsightRepository {
  String _normalizeLocale(String code) {
    if (code.contains('_')) return code.split('_')[0].toLowerCase();
    if (code.contains('-')) return code.split('-')[0].toLowerCase();
    return code.toLowerCase();
  }

  AppLocalizations _l10nFor(String languageCode) {
    return lookupAppLocalizations(Locale(_normalizeLocale(languageCode)));
  }

  ({String title, String description})? _earlyWeekData(
    int week,
    AppLocalizations l10n,
  ) {
    switch (week) {
      case 1:
        return (
          title: l10n.earlyWeek1Title,
          description: l10n.earlyWeek1Description,
        );
      case 2:
        return (
          title: l10n.earlyWeek2Title,
          description: l10n.earlyWeek2Description,
        );
      case 3:
        return (
          title: l10n.earlyWeek3Title,
          description: l10n.earlyWeek3Description,
        );
      default:
        return null;
    }
  }

  ({String title, String description}) getObjectData(
    int week,
    String languageCode,
    String visualModeKey,
  ) {
    final l10n = _l10nFor(languageCode);

    if (week < 4) {
      final specificData = _earlyWeekData(week, l10n);
      if (specificData != null) {
        return specificData;
      }
    }

    final safeWeek = week > 40 ? 40 : week;
    final weekData = localizedInsightKeyData[safeWeek];

    if (weekData != null) {
      final modeKey = visualModeKey;
      const fallbackKey = 'fruit';
      final obj =
          (weekData[modeKey] ?? weekData[fallbackKey]) as Map<String, dynamic>?;

      return (
        title: resolveInsightText(l10n, obj?['title']?.toString() ?? ''),
        description:
            resolveInsightText(l10n, obj?['description']?.toString() ?? ''),
      );
    }

    return (
      title: l10n.loadingTitle,
      description: l10n.updatingData,
    );
  }

  List<Insight> getInsightsForWeek(int week, String languageCode) {
    final l10n = _l10nFor(languageCode);
    final safeWeek = week < 4 ? 4 : (week > 40 ? 40 : week);
    final weekData = localizedInsightKeyData[safeWeek];

    if (weekData == null) {
      return [];
    }

    final rawInsights = weekData['insights'];
    if (rawInsights is! List) {
      return [];
    }

    return rawInsights.map((map) {
      final m = map as Map<String, dynamic>;
      final title = resolveInsightText(l10n, m['title'] as String? ?? '');
      return Insight(
        id: '${safeWeek}_${title.hashCode}',
        type: _parseType(m['type'] as String? ?? 'body'),
        title: title,
        content: resolveInsightText(l10n, m['content'] as String? ?? ''),
        iconName: m['icon'] as String? ?? 'info',
      );
    }).toList();
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

  WeekDetail getWeekDetail(int week, String languageCode) {
    final l10n = _l10nFor(languageCode);
    final safeWeek = week < 4 ? 4 : (week > 40 ? 40 : week);
    final weekData = localizedInsightKeyData[safeWeek];

    if (weekData != null) {
      final milestoneKey = weekData['milestone'] as String?;
      return WeekDetail(
        babyDev: resolveInsightText(l10n, weekData['babyDev'] as String? ?? ''),
        momBody: resolveInsightText(l10n, weekData['momBody'] as String? ?? ''),
        tip: resolveInsightText(l10n, weekData['tip'] as String? ?? ''),
        milestone: milestoneKey == null
            ? null
            : resolveInsightText(l10n, milestoneKey),
      );
    }

    return WeekDetail(
      babyDev: l10n.weekDetailBabyActive,
      momBody: l10n.weekDetailBodyChanging,
      tip: l10n.weekDetailRest,
    );
  }
}
