import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/app_constants.dart';

ThemeData light() => ThemeData(
      fontFamily: AppConstants.fontFamily,
      primaryColor: _Colors.primary,
      secondaryHeaderColor: _Colors.secondary,
      disabledColor: const Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: _Colors.surface,
      shadowColor: Colors.black.withValues(alpha: 0.03),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _Colors.primary,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: _Colors.primary,
        secondary: _Colors.secondary,
        surface: _Colors.surface,
        error: _Colors.error,
        onPrimary: _Colors.onPrimary,
        onSecondary: _Colors.onSecondary,
        onError: _Colors.onError,
        onSurface: _Colors.onSurface,
        onTertiary: _Colors.onTertiary,
        tertiary: _Colors.ternery,
        tertiaryFixed: _Colors.tertiaryFixed,
        secondaryFixed: Color(0xFFF5F5F5),
        onTertiaryFixed: Color(0xFFA1A1A1),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: _Colors.surface,
        surfaceTintColor: _Colors.surface,
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: _Colors.surface),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        surfaceTintColor: _Colors.surface,
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.2,
        color: _Colors.onTertiaryContainer,
      ),
      tabBarTheme: const TabBarThemeData(
        dividerColor: Colors.transparent,
      ),
    );

class _Colors {
  _Colors._();

  /// light theme colors
  static const Color primary = Color(0xFFF5BE01);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF333333);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onError = Color(0xFFE4042C);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);
  static const Color onTertiary = Color(0xFFD0D0D0);
  static const Color onTertiaryContainer = Color(0xFFF0F0F0);
  static const Color ternery = Color(0xFF01A8F5);
  // static const Color onTertiaryFixed = Color(0xFFA1A1A1);
  // static const Color onTertiaryFixedVariant = Color(0xFFE6E6E6);
  // static const Color onSecondaryFixed = Color(0xFF9C9C9C);
  // static const Color secondaryFixed = Color(0xFFF5F5F5);
  // static const Color tertiaryContainer = Color(0xFF455A64);
  // static const Color secondaryFixedDim = Color(0xFF6c6c6c);
  static const Color tertiaryFixed = Color(0xFF009867);
  // static const Color surfaceTint = Color(0xFF828282);
  // static const Color scrim = Color(0xFF632204);
  // static const Color tertiaryFixedDim = Color(0xFF093624);
  // static const Color surfaceContainerHigh = Color(0xFF65C8A0);

  /// dark theme colors
}
