import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColor.greyChateau,
      secondary: AppColor.linkWater,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColor.charade,
    ),
  );
}

class AppColor {
  static const whisper = Color(0xFFE5E5E5);
  static const linkWater = Color(0xFFC1C4C9);
  static const greyChateau = Color(0xFF9A9DA1);
  static const aluminium = Color(0xFF848586);
  static const midGrey = Color(0xFF656768);
  static const charade = Color(0xFF3E4142);

  static const deYork = Color(0xFF81c784);

  static const persianRed = Color(0xFFD63333);
}
