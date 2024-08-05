import 'package:excel_converter/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ));
}
