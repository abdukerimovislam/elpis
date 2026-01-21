import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Класс-контейнер для палитры
class AppPalette {
  final Color backgroundLight;
  final Color backgroundDark;
  final Color primary;
  final Color accent;
  final Color textMain;
  final Color textMuted;

  const AppPalette({
    required this.backgroundLight,
    required this.backgroundDark,
    required this.primary,
    required this.accent,
    required this.textMain,
    required this.textMuted,
  });
}

class AppTheme {
  // --- 1. ОПРЕДЕЛЯЕМ ПАЛИТРЫ ---

  // Organic Sage (Оригинал: Зеленый)
  static const _sagePalette = AppPalette(
    backgroundLight: Color(0xFFF9F7F2),
    backgroundDark: Color(0xFF1C1C1E),
    primary: Color(0xFF9CAF88),
    accent: Color(0xFFD4A373),
    textMain: Color(0xFF2C2C2C),
    textMuted: Color(0xFF8A8A8A),
  );

  // Warm Embrace (Персик: Теплый)
  static const _peachPalette = AppPalette(
    backgroundLight: Color(0xFFFFF8F5),
    backgroundDark: Color(0xFF2D2424),
    primary: Color(0xFFE29587),
    accent: Color(0xFFC77D63),
    textMain: Color(0xFF4A3B39),
    textMuted: Color(0xFF9C8C89),
  );

  // Deep Serenity (Синий: Текущий)
  static const _serenityPalette = AppPalette(
    backgroundLight: Color(0xFFF4F6F9),
    backgroundDark: Color(0xFF151922),
    primary: Color(0xFF7D93B2),
    accent: Color(0xFF4A6583),
    textMain: Color(0xFF242A36),
    textMuted: Color(0xFF8DA3B5),
  );

  // Карта доступа к палитрам по ключу
  static const Map<String, AppPalette> _palettes = {
    'sage': _sagePalette,
    'peach': _peachPalette,
    'serenity': _serenityPalette,
  };

  // Метод для получения ThemeData по ключу
  static ThemeData getTheme(String themeKey) {
    final palette = _palettes[themeKey] ?? _serenityPalette; // По дефолту синяя

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: palette.backgroundLight,
      primaryColor: palette.primary,

      // Определяем цветовую схему Material 3 на основе нашей палитры
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        primary: palette.primary,
        secondary: palette.accent,
        background: palette.backgroundLight,
        surface: palette.backgroundLight,
        onSurface: palette.textMain,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.getEmotionalHeader(palette.textMain),
        bodyMedium: AppTextStyles.getCalmBody(palette.textMain),
        labelSmall: AppTextStyles.getWhisperLabel(palette.textMuted),
      ),

      dividerTheme: const DividerThemeData(color: Colors.transparent),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: palette.textMain),
      ),
    );
  }
}

// Стили текста теперь динамически принимают цвет
class AppTextStyles {
  static TextStyle getEmotionalHeader(Color color) => GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle getCalmBody(Color color) => GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.5,
  );

  static TextStyle getWhisperLabel(Color color) => GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 1.0,
    height: 1.4,
  );
}