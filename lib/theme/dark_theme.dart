import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/app_constants.dart';

ThemeData dark() => ThemeData(
      fontFamily: AppConstants.fontFamily,
      primaryColor: _Colors.primaryDark,
      secondaryHeaderColor: _Colors.secondaryDark,
      disabledColor: const Color(0xffa2a7ad),
      brightness: Brightness.dark,
      hintColor: const Color(0xFFbebebe),
      cardColor: _Colors.surfaceDark,
      shadowColor: Colors.white.withValues(alpha: 0.03),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _Colors.primaryDark,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _Colors.primaryDark,
        secondary: _Colors.secondaryDark,
        surface: _Colors.surfaceDark,
        error: _Colors.errorDark,
        onPrimary: _Colors.onPrimaryDark,
        onSecondary: _Colors.onSecondaryDark,
        onError: _Colors.onErrorDark,
        onSurface: _Colors.onSurfaceDark,
        onTertiary: _Colors.onTertiaryDark,
        tertiary: _Colors.terneryDark,
        tertiaryFixed: _Colors.tertiaryFixedDark,
        secondaryFixed: Color(0xFF828282),
        onTertiaryFixed: Color(0xFF888888),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: _Colors.surfaceDark,
        surfaceTintColor: _Colors.surfaceDark,
      ),
      dialogTheme: const DialogThemeData(
        surfaceTintColor: Colors.white10,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        surfaceTintColor: Colors.black,
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.5,
        color: _Colors.onTertiaryContainerDark,
      ),
      tabBarTheme: const TabBarThemeData(
        dividerColor: Colors.transparent,
      ),
    );

class _Colors {
  _Colors._();

  /// light theme colors
  static const Color primaryDark = Color(0xFFF5BE01);
  static const Color onPrimaryDark = Color(0xFF333333);
  static const Color secondaryDark = Color.fromARGB(255, 255, 255, 255);
  static const Color onSecondaryDark = Color(0xFF202126);
  static const Color errorDark = Color(0xFFB00020);
  static const Color onErrorDark = Color(0xFFE4042C);
  static const Color surfaceDark = Color(0xFF000000);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onTertiaryDark = Color(0xFFB0B0B0);
  static const Color onTertiaryContainerDark = Color(0xFF6C6C6C);
  static const Color terneryDark = Color(0xFF01A8F5);
  // static const Color onTertiaryFixedDark = Color(0xFF888888);
  // static const Color onTertiaryFixedVariantDark = Color(0xff454545);
  // static const Color onSecondaryFixedDark = Color(0xFF9C9C9C);
  // static const Color secondaryFixedDark = Color(0xFF828282);
  // static const Color tertiaryContainerDark = Color(0xFF263238);
  // static const Color secondaryFixedDimDark = Color(0xFFB3B3B3);
  static const Color tertiaryFixedDark = Color(0xFF009867);
  // static const Color surfaceTintDark = Color(0xFF999999);
  // static const Color scrimDark = Color(0xFF632204);
  // static const Color tertiaryFixedDimDark = Color(0xFF093624);
  // static const Color surfaceContainerHighDark = Color(0xFF65C8A0);
  // static const Color surfaceTintDark = Color(0xFF828282);
}
