import 'package:flutter/foundation.dart';

/// Модель, описывающая эмоциональную привязку к будущему ребенка.
/// Вместо "размером с лайм" мы говорим "Первый деревянный кубик".
@immutable
class FutureLifeObject {
  final String title; // Заголовок (Например: "Первый деревянный кубик")
  final String
      momentDescription; // Эмоциональное описание момента (Например: "Фундамент башни...")
  final String?
      assetPath; // Путь к картинке (в будущем здесь будет красивое фото предмета)

  const FutureLifeObject({
    required this.title,
    required this.momentDescription,
    this.assetPath,
  });
}
