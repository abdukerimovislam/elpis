// Убираем import 'package:flutter/material.dart';

enum InsightType { body, mind, action, baby }

class Insight {
  final String id;
  final String title;
  final String content;
  final InsightType type;

  // Храним СТРОКУ, а не ИКОНКУ.
  // Например: "water_drop", "heart", "baby"
  final String iconName;

  const Insight({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.iconName,
  });
}

/// Расширенные данные по конкретной неделе беременности.
/// Отображается в секции «На этой неделе» в панели деталей.
class WeekDetail {
  /// Что происходит с малышом (2–3 предложения).
  final String babyDev;

  /// Что меняется у мамы (2–3 предложения).
  final String momBody;

  /// Главный совет недели (1 предложение).
  final String tip;

  /// Особое событие на этой неделе (УЗИ, скрининг и т.д.).
  /// Null если ничего особенного.
  final String? milestone;

  const WeekDetail({
    required this.babyDev,
    required this.momBody,
    required this.tip,
    this.milestone,
  });
}
