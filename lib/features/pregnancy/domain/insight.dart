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
