import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ElpisColors — semantic colors for the Elpis design system.
// Access via Theme.of(context).elpisColors.
class ElpisColors extends ThemeExtension<ElpisColors> {
  final Color powderPink;
  final Color peach;
  final Color milky;
  final Color lightBeige;
  final Color sage;
  final Color forest;

  final Color textMain;
  final Color textMuted;

  final Color weekColor;
  final Color symptomsColor;
  final Color notesColor;
  final Color eventsColor;

  const ElpisColors({
    required this.powderPink,
    required this.peach,
    required this.milky,
    required this.lightBeige,
    required this.sage,
    required this.forest,
    required this.textMain,
    required this.textMuted,
    required this.weekColor,
    required this.symptomsColor,
    required this.notesColor,
    required this.eventsColor,
  });

  static const List<Color> _weekPastelCycle = [
    Color(0xFFE8C6C8),
    Color(0xFFF3D2C1),
    Color(0xFFA8C3A0),
    Color(0xFF6F8F6B),
    Color(0xFFF2E8DC),
    Color(0xFFFFF8F0),
  ];

  Color weekPastel(int week) =>
      _weekPastelCycle[(week - 1).clamp(0, 41) % _weekPastelCycle.length];

  static Color softBackground(Color base, {double alpha = 0.18}) =>
      base.withValues(alpha: alpha);

  // Backward-compatible aliases for existing screens while the app migrates.
  Color get mint => sage;
  Color get lavender => peach;
  Color get dustyRose => forest;
  Color get textBrown => textMain;

  @override
  ElpisColors copyWith({
    Color? powderPink,
    Color? peach,
    Color? milky,
    Color? lightBeige,
    Color? sage,
    Color? forest,
    Color? textMain,
    Color? textMuted,
    Color? weekColor,
    Color? symptomsColor,
    Color? notesColor,
    Color? eventsColor,
  }) {
    return ElpisColors(
      powderPink: powderPink ?? this.powderPink,
      peach: peach ?? this.peach,
      milky: milky ?? this.milky,
      lightBeige: lightBeige ?? this.lightBeige,
      sage: sage ?? this.sage,
      forest: forest ?? this.forest,
      textMain: textMain ?? this.textMain,
      textMuted: textMuted ?? this.textMuted,
      weekColor: weekColor ?? this.weekColor,
      symptomsColor: symptomsColor ?? this.symptomsColor,
      notesColor: notesColor ?? this.notesColor,
      eventsColor: eventsColor ?? this.eventsColor,
    );
  }

  @override
  ElpisColors lerp(ElpisColors? other, double t) {
    if (other == null) return this;
    return ElpisColors(
      powderPink: Color.lerp(powderPink, other.powderPink, t)!,
      peach: Color.lerp(peach, other.peach, t)!,
      milky: Color.lerp(milky, other.milky, t)!,
      lightBeige: Color.lerp(lightBeige, other.lightBeige, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      forest: Color.lerp(forest, other.forest, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      weekColor: Color.lerp(weekColor, other.weekColor, t)!,
      symptomsColor: Color.lerp(symptomsColor, other.symptomsColor, t)!,
      notesColor: Color.lerp(notesColor, other.notesColor, t)!,
      eventsColor: Color.lerp(eventsColor, other.eventsColor, t)!,
    );
  }

  static const ElpisColors instance = ElpisColors(
    powderPink: Color(0xFFE8C6C8),
    peach: Color(0xFFF3D2C1),
    milky: Color(0xFFFFF8F0),
    lightBeige: Color(0xFFF2E8DC),
    sage: Color(0xFFA8C3A0),
    forest: Color(0xFF6F8F6B),
    textMain: Color(0xFF4A4A4A),
    textMuted: Color(0xFF8A8A8A),
    weekColor: Color(0xFFF3D2C1),
    symptomsColor: Color(0xFFE8C6C8),
    notesColor: Color(0xFFF2E8DC),
    eventsColor: Color(0xFFA8C3A0),
  );

  static const ElpisColors dark = ElpisColors(
    powderPink: Color(0xFF5C3A3C),
    peach: Color(0xFF5C4438),
    milky: Color(0xFF1E1612),
    lightBeige: Color(0xFF2A2018),
    sage: Color(0xFF4A6B45),
    forest: Color(0xFF3A5C38),
    textMain: Color(0xFFF0EAE4),
    textMuted: Color(0xFF9A9490),
    weekColor: Color(0xFF5C4438),
    symptomsColor: Color(0xFF5C3A3C),
    notesColor: Color(0xFF2A2018),
    eventsColor: Color(0xFF4A6B45),
  );
}

extension ThemeElpisColors on ThemeData {
  ElpisColors get elpisColors =>
      extension<ElpisColors>() ?? ElpisColors.instance;
}

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
  AppTheme._();

  static const AppPalette _lightPalette = AppPalette(
    backgroundLight: Color(0xFFFFF8F0),
    backgroundDark: Color(0xFF1E1612),
    primary: Color(0xFFA8C3A0),
    accent: Color(0xFF6F8F6B),
    cardColor: Color(0xFFF2E8DC),
    textMain: Color(0xFF4A4A4A),
    textMuted: Color(0xFF8A8A8A),
    auraColor: Color(0xFFE8C6C8),
    pearlColors: [
      Color(0xFFE8C6C8),
      Color(0xFFF3D2C1),
      Color(0xFFA8C3A0),
      Color(0xFF6F8F6B),
      Color(0xFFF2E8DC),
      Color(0xFFE8C6C8),
    ],
  );

  static AppPalette getPalette(int? week) => _lightPalette;

  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        elpisColors: ElpisColors.instance,
        background: ElpisColors.instance.milky,
        surface: ElpisColors.instance.lightBeige,
        primary: ElpisColors.instance.sage,
        accent: ElpisColors.instance.forest,
        textMain: ElpisColors.instance.textMain,
        textMuted: ElpisColors.instance.textMuted,
      );

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        elpisColors: ElpisColors.dark,
        background: ElpisColors.dark.milky,
        surface: ElpisColors.dark.lightBeige,
        primary: ElpisColors.dark.sage,
        accent: ElpisColors.dark.forest,
        textMain: ElpisColors.dark.textMain,
        textMuted: ElpisColors.dark.textMuted,
      );

  static ThemeData of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  // Backward-compatible entrypoint used across the app.
  static ThemeData getTheme({int? week, String? themeKey, Brightness? brightness}) {
    return of(brightness ?? Brightness.light);
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ElpisColors elpisColors,
    required Color background,
    required Color surface,
    required Color primary,
    required Color accent,
    required Color textMain,
    required Color textMuted,
  }) {
    final textTheme = _buildTextTheme(textMain, textMuted);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      cardColor: surface,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: surface,
        onSurface: textMain,
        error: const Color(0xFFB00020),
        onError: Colors.white,
        primaryContainer: primary.withValues(alpha: 0.15),
        onPrimaryContainer: accent,
        secondaryContainer: elpisColors.peach.withValues(alpha: 0.4),
        onSecondaryContainer: textMain,
        surfaceContainerHighest: background,
        outline: textMuted.withValues(alpha: 0.3),
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textMain),
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: BorderSide(color: accent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.lato(
          fontSize: 14,
          color: textMuted,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        labelStyle: textTheme.labelSmall,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
        thickness: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: background,
        selectedItemColor: accent,
        unselectedItemColor: textMuted,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      extensions: [elpisColors],
    );
  }

  static TextTheme _buildTextTheme(Color textMain, Color textMuted) {
    return TextTheme(
      displayLarge: AppTextStyles.emotional(textMain, size: 36),
      displayMedium: AppTextStyles.emotional(textMain, size: 28),
      displaySmall: AppTextStyles.emotional(textMain, size: 24),
      headlineLarge: AppTextStyles.emotional(textMain, size: 22),
      headlineMedium: AppTextStyles.emotional(textMain, size: 20),
      headlineSmall: AppTextStyles.emotional(textMain, size: 18),
      titleLarge: AppTextStyles.calm(
        textMain,
        size: 18,
        weight: FontWeight.w600,
      ),
      titleMedium: AppTextStyles.calm(
        textMain,
        size: 16,
        weight: FontWeight.w600,
      ),
      titleSmall: AppTextStyles.calm(
        textMain,
        size: 14,
        weight: FontWeight.w600,
      ),
      bodyLarge: AppTextStyles.calm(textMain, size: 16),
      bodyMedium: AppTextStyles.calm(textMain, size: 14),
      bodySmall: AppTextStyles.calm(textMuted, size: 12),
      labelLarge: AppTextStyles.calm(
        textMain,
        size: 15,
        weight: FontWeight.w600,
      ),
      labelMedium: AppTextStyles.whisper(textMuted, size: 13),
      labelSmall: AppTextStyles.whisper(textMuted, size: 11),
    );
  }
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle emotional(
    Color color, {
    double size = 32,
    FontWeight weight = FontWeight.w600,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.2,
      letterSpacing: -0.3,
    );
  }

  static TextStyle calm(
    Color color, {
    double size = 16,
    FontWeight weight = FontWeight.w400,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle whisper(
    Color color, {
    double size = 12,
    FontWeight weight = FontWeight.w500,
  }) {
    return GoogleFonts.lato(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: 0.8,
      height: 1.4,
    );
  }

  // Backward-compatible helpers used by older screens.
  static TextStyle getEmotionalHeader(Color color) => emotional(color);
  static TextStyle getCalmBody(Color color) => calm(color);
  static TextStyle getWhisperLabel(Color color) => whisper(color);
}
