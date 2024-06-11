import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(162, 29, 19, 1);
  static Color primaryAccent = const Color.fromRGBO(120, 14, 14, 1);
  static Color secondaryColor = const Color.fromRGBO(45, 45, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(35, 35, 35, 1);
  static Color titleColor = const Color.fromRGBO(200, 200, 200, 1);
  static Color textColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color successColor = const Color.fromRGBO(9, 149, 110, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

ThemeData primaryTheme = ThemeData(
    // seed color
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.secondaryAccent,

    // app bar theme
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.textColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        )),

    // navigation bar theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.secondaryColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(
            color: Colors.black,
          );
        }
        return const IconThemeData(
          color: Colors.grey,
        );
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.0,
          );
        }
        return const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          letterSpacing: 1.0,
        );
      }),
    ),

    // text theme
    textTheme: TextTheme(
      bodyMedium:
          TextStyle(color: AppColors.textColor, fontSize: 16, letterSpacing: 1),
      headlineMedium: TextStyle(
          color: AppColors.titleColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1),
      titleMedium: TextStyle(
          color: AppColors.titleColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2),
    ),

    // card theme
    cardTheme: CardTheme(
        color: AppColors.secondaryColor.withOpacity(.5),
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 16)),

    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryColor.withOpacity(.5),
        border: InputBorder.none,
        labelStyle: TextStyle(color: AppColors.textColor),
        prefixIconColor: AppColors.textColor),

    // dialog theme
    dialogTheme: DialogTheme(
        backgroundColor: AppColors.secondaryAccent,
        surfaceTintColor: Colors.transparent));
