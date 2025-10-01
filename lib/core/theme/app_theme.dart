import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFA902);
  static const Color secondaryColor = Color(0xFFDCF7F9);

  static ThemeData get theme {
    final ColorScheme baseScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
    );

    return ThemeData(
      colorScheme: baseScheme.copyWith(secondary: secondaryColor),
      useMaterial3: true,
    );
  }
}
