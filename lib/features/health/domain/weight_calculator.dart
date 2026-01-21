import '../../../l10n/app_localizations.dart';

class WeightCalculator {

  /// Расчет ИМТ (BMI): Вес (кг) / (Рост (м) * Рост (м))
  static double calculateBMI(double weightKg, double heightCm) {
    if (heightCm <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Получить "Коридор нормы" (Min, Max) на основе рекомендаций IOM (Institute of Medicine)
  /// Возвращает Record: (min: кг, max: кг)
  static ({double min, double max}) getRangeForWeek(double startBmi, int weekInput) {
    // Ограничиваем неделю, чтобы на 42+ неделе график не улетал в космос
    final week = weekInput.clamp(0, 42);

    if (week < 0) return (min: 0.0, max: 0.0);

    // 1. Недостаточный вес (BMI < 18.5)
    // Рекомендация: 12.5 - 18 кг за всю беременность
    if (startBmi < 18.5) {
      if (week <= 12) {
        // 1-й триместр: плавный набор 0.5 - 2.0 кг
        return (min: 0.5 * (week / 12), max: 2.0 * (week / 12));
      }
      // 2-й и 3-й триместр: ~0.5 кг в неделю
      return (
      min: 0.5 + (week - 12) * 0.44,
      max: 2.0 + (week - 12) * 0.58
      );
    }
    // 2. Норма (BMI 18.5 - 24.9)
    // Рекомендация: 11.5 - 16 кг
    else if (startBmi < 25.0) {
      if (week <= 12) return (min: 0.5, max: 2.0);
      return (
      min: 1.0 + (week - 12) * 0.35,
      max: 2.0 + (week - 12) * 0.50
      );
    }
    // 3. Избыточный вес (BMI 25 - 29.9)
    // Рекомендация: 7 - 11.5 кг
    else if (startBmi < 30.0) {
      if (week <= 12) return (min: 0.5, max: 1.5);
      return (
      min: 0.5 + (week - 12) * 0.23,
      max: 1.5 + (week - 12) * 0.33
      );
    }
    // 4. Ожирение (BMI > 30)
    // Рекомендация: 5 - 9 кг
    else {
      if (week <= 12) return (min: 0.0, max: 1.0);
      return (
      min: 0.0 + (week - 12) * 0.17,
      max: 1.0 + (week - 12) * 0.27
      );
    }
  }

  /// Получить текстовый совет
  static String getFeedback(double currentGain, double min, double max, AppLocalizations l10n) {
    // Даем небольшой буфер (1 кг), чтобы не пугать маму из-за стакана воды
    const buffer = 1.0;

    if (currentGain < min - buffer) {
      return l10n.weightFeedbackLow;
    }
    if (currentGain > max + buffer) {
      return l10n.weightFeedbackHigh;
    }
    return l10n.weightFeedbackNormal;
  }
}