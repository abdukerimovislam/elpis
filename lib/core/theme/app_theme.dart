import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────
// ElpisColors — семантические цвета для конкретных контекстов.
// Подключается как расширение темы: Theme.of(context).elpisColors
// ─────────────────────────────────────────────────────────────────
class ElpisColors extends ThemeExtension<ElpisColors> {
  // ── Основные пастельные оттенки ──
  final Color powderPink;    // #F7C6C7 — пудрово-розовый
  final Color peach;         // #FAD4C0 — персиковый
  final Color milky;         // #FFF5F0 — молочный
  final Color lightBeige;    // #F2E4D7 — светло-бежевый
  final Color mint;          // #DCEFE6 — мятный
  final Color lavender;      // #E6DDF2 — лавандовый

  // ── Акценты ──
  final Color dustyRose;     // #E8A9A9 — пыльно-розовый (кнопки, иконки)
  final Color textBrown;     // #6D5C5C — серо-коричневый (текст)

  // ── Контекстные цвета (по назначению) ──
  final Color weekColor;       // Недели беременности → разные пастели (base: peach)
  final Color symptomsColor;   // Симптомы → розово-персиковый
  final Color notesColor;      // Заметки → беж/молочный
  final Color eventsColor;     // Важные события → лавандовый / мятный

  const ElpisColors({
    required this.powderPink,
    required this.peach,
    required this.milky,
    required this.lightBeige,
    required this.mint,
    required this.lavender,
    required this.dustyRose,
    required this.textBrown,
    required this.weekColor,
    required this.symptomsColor,
    required this.notesColor,
    required this.eventsColor,
  });

  /// Возвращает пастельный цвет недели (циклически по 6 оттенкам).
  Color weekPastel(int week) {
    const pastelCycle = [
      Color(0xFFE8C6C8), // вторичный акцент 1
      Color(0xFFF3D2C1), // вторичный акцент 2
      Color(0xFFA8C3A0), // основной
      Color(0xFF6F8F6B), // акцент
      Color(0xFFF2E8DC), // карточки
      Color(0xFFFFF8F0), // фон
    ];
    return pastelCycle[(week - 1).clamp(0, 41) % pastelCycle.length];
  }

  @override
  ElpisColors copyWith({
    Color? powderPink, Color? peach, Color? milky, Color? lightBeige,
    Color? mint, Color? lavender, Color? dustyRose, Color? textBrown,
    Color? weekColor, Color? symptomsColor, Color? notesColor, Color? eventsColor,
  }) => ElpisColors(
    powderPink: powderPink ?? this.powderPink,
    peach: peach ?? this.peach,
    milky: milky ?? this.milky,
    lightBeige: lightBeige ?? this.lightBeige,
    mint: mint ?? this.mint,
    lavender: lavender ?? this.lavender,
    dustyRose: dustyRose ?? this.dustyRose,
    textBrown: textBrown ?? this.textBrown,
    weekColor: weekColor ?? this.weekColor,
    symptomsColor: symptomsColor ?? this.symptomsColor,
    notesColor: notesColor ?? this.notesColor,
    eventsColor: eventsColor ?? this.eventsColor,
  );

  @override
  ElpisColors lerp(ElpisColors? other, double t) {
    if (other == null) return this;
    return ElpisColors(
      powderPink:    Color.lerp(powderPink, other.powderPink, t)!,
      peach:         Color.lerp(peach, other.peach, t)!,
      milky:         Color.lerp(milky, other.milky, t)!,
      lightBeige:    Color.lerp(lightBeige, other.lightBeige, t)!,
      mint:          Color.lerp(mint, other.mint, t)!,
      lavender:      Color.lerp(lavender, other.lavender, t)!,
      dustyRose:     Color.lerp(dustyRose, other.dustyRose, t)!,
      textBrown:     Color.lerp(textBrown, other.textBrown, t)!,
      weekColor:     Color.lerp(weekColor, other.weekColor, t)!,
      symptomsColor: Color.lerp(symptomsColor, other.symptomsColor, t)!,
      notesColor:    Color.lerp(notesColor, other.notesColor, t)!,
      eventsColor:   Color.lerp(eventsColor, other.eventsColor, t)!,
    );
  }

  // Единственный экземпляр палитры
  static const instance = ElpisColors(
    powderPink:    Color(0xFFE8C6C8),
    peach:         Color(0xFFF3D2C1),
    milky:         Color(0xFFFFF8F0),
    lightBeige:    Color(0xFFF2E8DC),
    mint:          Color(0xFFA8C3A0),
    lavender:      Color(0xFF6F8F6B),
    dustyRose:     Color(0xFFE8C6C8),
    textBrown:     Color(0xFF4A4A4A),
    weekColor:     Color(0xFFF3D2C1),
    symptomsColor: Color(0xFFE8C6C8),
    notesColor:    Color(0xFFF2E8DC),
    eventsColor:   Color(0xFFA8C3A0),
  );
}

/// Удобный extension для доступа к ElpisColors
extension ThemeElpisColors on ThemeData {
  ElpisColors get elpisColors =>
      extension<ElpisColors>() ?? ElpisColors.instance;
}

// ─────────────────────────────────────────────────────────────────
// AppPalette — внутренняя структура для ThemeData
// ─────────────────────────────────────────────────────────────────
class AppPalette {
  final Color backgroundLight;
  final Color backgroundDark;
  final Color primary;
  final Color accent;
  final Color cardColor;
  final Color textMain;
  final Color textMuted;
  final Color auraColor;
  final List<Color> pearlColors;

  const AppPalette({
    required this.backgroundLight,
    required this.backgroundDark,
    required this.primary,
    required this.accent,
    required this.cardColor,
    required this.textMain,
    required this.textMuted,
    required this.auraColor,
    required this.pearlColors,
  });
}

class AppTheme {
  // ─── Дизайн-система Elpis ───────────────────────────────────────
  //  Пудрово-розовый #F7C6C7 · Персиковый #FAD4C0 · Молочный #FFF5F0
  //  Светло-бежевый #F2E4D7 · Мятный #DCEFE6 · Лавандовый #E6DDF2
  //  Акцент: Пыльно-розовый #E8A9A9 · Текст: #6D5C5C
  // ────────────────────────────────────────────────────────────────
  static const _elpisPalette = AppPalette(
    // Фон: #FFF8F0
    backgroundLight: Color(0xFFFFF8F0),
    backgroundDark:  Color(0xFF221818),
    // Основной цвет: #A8C3A0
    primary: Color(0xFFA8C3A0),
    // Акцент: #6F8F6B
    accent: Color(0xFF6F8F6B),
    // Карточки: #F2E8DC
    cardColor: Color(0xFFF2E8DC),
    // Текст: #4A4A4A
    textMain: Color(0xFF4A4A4A),
    // Подпись / muted
    textMuted: Color(0xFF8A8A8A),
    // Аура сферы — вторичный акцент: #E8C6C8
    auraColor: Color(0xFFE8C6C8),
    // Перл-ободок — использование вторичных акцентов
    pearlColors: [
      Color(0xFFE8C6C8), // Вторичный акцент 1
      Color(0xFFF3D2C1), // Вторичный акцент 2
      Color(0xFFA8C3A0), // Основной
      Color(0xFF6F8F6B), // Акцент
      Color(0xFFF2E8DC), // Карточки
      Color(0xFFE8C6C8), // loop
    ],
  );

  static AppPalette getPalette(int? week) => _elpisPalette;

  static ThemeData getTheme({int? week, String? themeKey}) {
    final palette = getPalette(week);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: palette.backgroundLight,
      primaryColor: palette.primary,
      cardColor: palette.cardColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        primary: palette.primary,
        secondary: palette.accent,
        surface: palette.backgroundLight,
        onSurface: palette.textMain,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.getEmotionalHeader(palette.textMain),
        bodyMedium: AppTextStyles.getCalmBody(palette.textMain),
        bodyLarge: AppTextStyles.getCalmBody(palette.textMain)
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        labelSmall: AppTextStyles.getWhisperLabel(palette.textMuted),
      ),
      extensions: const [ElpisColors.instance],
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

// ─────────────────────────────────────────────────────────────────
// AppTextStyles
// ─────────────────────────────────────────────────────────────────
class AppTextStyles {
  static TextStyle getEmotionalHeader(Color color) =>
      GoogleFonts.playfairDisplay(
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
