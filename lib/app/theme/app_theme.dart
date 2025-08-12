import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontFamily.satoshi,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _Colors.primary,
      onPrimary: _Colors.onPrimary,
      secondary: _Colors.secondary,
      onSecondary: _Colors.onSecondary,
      error: _Colors.error,
      onError: _Colors.onError,
      surface: _Colors.surface,
      onSurface: _Colors.onSurface,
      onTertiary: _Colors.onTertiary,
      tertiary: _Colors.ternery,
      onTertiaryContainer: _Colors.onTertiaryContainer,
      onTertiaryFixed: _Colors.onTertiaryFixed,
      onTertiaryFixedVariant: _Colors.onTertiaryFixedVariant,
      onSecondaryFixed: _Colors.onSecondaryFixed,
      // onSecondaryFixedVariant: _Colors.onSecondaryFixedVariant,
      tertiaryContainer: _Colors.tertiaryContainer,
      secondaryFixed: _Colors.secondaryFixed,
      secondaryFixedDim: _Colors.secondaryFixedDim,
      tertiaryFixed: _Colors.tertiaryFixed,
      surfaceTint: _Colors.surfaceTint,
      scrim: _Colors.scrim,
      tertiaryFixedDim: _Colors.tertiaryFixedDim,
      surfaceContainerHigh: _Colors.surfaceContainerHigh,
    ),
  );

  /// Dark theme configuration
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: FontFamily.satoshi,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _Colors.primaryDark,
      onPrimary: _Colors.onPrimaryDark,
      secondary: _Colors.secondaryDark,
      onSecondary: _Colors.onSecondaryDark,
      error: _Colors.errorDark,
      onError: _Colors.onErrorDark,
      surface: _Colors.surfaceDark,
      onSurface: _Colors.onSurfaceDark,
      onTertiary: _Colors.onTertiaryDark,
      tertiary: _Colors.terneryDark,
      onTertiaryContainer: _Colors.onTertiaryContainerDark,
      onTertiaryFixed: _Colors.onTertiaryFixedDark,
      onTertiaryFixedVariant: _Colors.onTertiaryFixedVariantDark,
      onSecondaryFixed: _Colors.onSecondaryFixedDark,
      secondaryFixed: _Colors.secondaryFixedDark,
      tertiaryContainer: _Colors.tertiaryContainerDark,
      secondaryFixedDim: _Colors.secondaryFixedDimDark,
      tertiaryFixed: _Colors.tertiaryFixedDark,
      surfaceTint: _Colors.surfaceTintDark,
      scrim: _Colors.scrimDark,
      tertiaryFixedDim: _Colors.tertiaryFixedDimDark,
      surfaceContainerHigh: _Colors.surfaceContainerHighDark,
    ),
  );
}

class _Colors {
  _Colors._();

  /// light theme colors
  static const Color primary = Color(0xFF000000);
  static const Color primaryDark = Color(0xFFFFFFFF);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF000000);

  static const Color secondary = Color(0xFFF5BE01);
  static const Color secondaryDark = Color(0xFFF5BE01);

  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFF202126);

  static const Color error = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFB00020);

  static const Color onError = Color(0xFFE4042C);
  static const Color onErrorDark = Color(0xFFE4042C);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF000000);

  static const Color onSurface = Color(0xFF000000);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);

  static const Color onTertiary = Color(0xFFD0D0D0);
  static const Color onTertiaryDark = Color(0xFFB0B0B0);

  static const Color onTertiaryContainer = Color(0xFFF0F0F0);
  static const Color onTertiaryContainerDark = Color(0xFF6C6C6C);

  static const Color ternery = Color(0xFF01A8F5);
  static const Color terneryDark = Color(0xFF01A8F5);

  static const Color onTertiaryFixed = Color(0xFFA1A1A1);
  static const Color onTertiaryFixedDark = Color(0xFF888888);

  static const Color onTertiaryFixedVariant = Color(0xFFE6E6E6);
  static const Color onTertiaryFixedVariantDark = Color(0xff454545);

  static const Color onSecondaryFixed = Color(0xFF9C9C9C);
  static const Color onSecondaryFixedDark = Color(0xFF9C9C9C);

  static const Color secondaryFixed = Color(0xFFF5F5F5);
  static const Color secondaryFixedDark = Color(0xFF828282);

  static const Color tertiaryContainer = Color(0xFF455A64);
  static const Color tertiaryContainerDark = Color(0xFF263238);

  static const Color secondaryFixedDim = Color(0xFF6c6c6c);
  static const Color secondaryFixedDimDark = Color(0xFFB3B3B3);

  static const Color tertiaryFixed = Color(0xFF009867);
  static const Color tertiaryFixedDark = Color(0xFF009867);

  static const Color surfaceTint = Color(0xFF828282);
  static const Color surfaceTintDark = Color(0xFF999999);

  static const Color scrim = Color(0xFF632204);
  static const Color scrimDark = Color(0xFF632204);

  static const Color tertiaryFixedDim = Color(0xFF093624);
  static const Color tertiaryFixedDimDark = Color(0xFF093624);

  static const Color surfaceContainerHigh = Color(0xFF65C8A0);
  static const Color surfaceContainerHighDark = Color(0xFF65C8A0);

  /// dark theme colors
  // static const Color primaryDark = Color(0xFF3700B3);
  // static const Color onPrimaryDark = Color(0xFFFFFFFF);
  // static const Color secondaryDark = Color(0xFF03DAC6);
  // static const Color onSecondaryDark = Color(0xFF000000);
  // static const Color errorDark = Color(0xFFCF6679);
  // static const Color onErrorDark = Color(0xFFCF6679);
  // static const Color surfaceDark = Color(0xFF121212);
  // static const Color onSurfaceDark = Color(0xFFFFFFFF);
  // static const Color onTerneryDark = Color(0xFFD0D0D0);
  // static const Color onTertiaryContainerDark = Color(0xFFF0F0F0);
  // static const Color terneryDark = Color(0xFF01A8F5);
  // static const Color onTertiaryFixedDark = Color(0xFFA1A1A1);
  // static const Color onTertiaryFixedVariantDark = Color(0xFFE6E6E6);
  // static const Color onSecondaryFixedDark = Color(0xFF9C9C9C);
  // static const Color secondaryFixedDark = Color(0xFFF5F5F5);
  // static const Color tertiaryContainerDark = Color(0xFF455A64);
  // static const Color secondaryFixedDimDark = Color(0xFF6c6c6c);
  // static const Color tertiaryFixedDark = Color(0xFF009867);
  // static const Color surfaceTintDark = Color(0xFF828282);
}

class FontFamily {
  FontFamily._();

  static const String satoshi = 'Satoshi';
}
