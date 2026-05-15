import 'package:flutter/material.dart';

class AppConstTheme {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    fontFamily: 'Roboto',

    scaffoldBackgroundColor: AppConstColor.backgroundGray,
    cardColor: AppConstColor.backgroundWhite,
    dividerColor: Colors.grey.withOpacity(0.2),

    primaryColor: AppConstColor.primaryColor,

    colorScheme: const ColorScheme.light(
      primary: AppConstColor.primaryColor,
      secondary: AppConstColor.accentColor,
      surface: AppConstColor.backgroundWhite,
      background: AppConstColor.backgroundGray,
      onPrimary: Colors.white,
      onSurface: AppConstColor.textBlackColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppConstColor.textBlackColor),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppConstColor.textBlackColor,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstColor.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),

    textTheme: _textTheme,
  );

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppConstColor.textBlackColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppConstColor.textBlackColor,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppConstColor.textBlackColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppConstColor.textBlackColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppConstColor.textGrey,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

class AppConstColor {
  static const Color primaryColor = Color(0xFFFBB03B);
  static const Color accentColor = Color(0xFFFDC959);

  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGray = Color(
    0xFFF8F8F8,
  );

  static const Color textBlackColor = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF757575);

  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFE53935);
}
