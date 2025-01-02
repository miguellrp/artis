import 'package:flutter/material.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);
  static final Color _darkFocusColor = Colors.white.withValues(alpha: 0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  /* ☀️ LIGHT SCHEME ☀️ */
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFBBB834),
    onPrimary: Colors.black,
    secondary: Color(0xFFBA794B),
    onSecondary: Color(0xFF322942),
    surface: Color(0xFFE6EBEB),
    onSurface: Colors.black26,
    onSurfaceVariant: Colors.black54,
    tertiary: Color(0xFFE7E7AC),
    onTertiary: Color(0xFFD28218),
    error: Colors.redAccent,
    onError: Colors.white,
    brightness: Brightness.light
  );

  /* 🌙 DARK SCHEME 🌙 */
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFBBB834),
    onPrimary: Colors.black,
    secondary: Color(0xFFBA794B),
    onSecondary: Color(0xFF322942),
    surface: Color(0xFF241E30),
    onSurface: Color(0xFF3C3354),
    onSurfaceVariant: Colors.white70,
    tertiary: Color(0xFF392F4B),
    onTertiary: Color(0xFF9687C4),
    error: Colors.redAccent,
    onError: Colors.white,
    brightness: Brightness.dark
  );

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: "RobotoSlab",
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }
}