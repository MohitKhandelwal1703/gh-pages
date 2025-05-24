import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2D2E32);
  static const Color secondaryColor = Color(0xFF64FFDA);
  static const Color backgroundColor = Color(0xFF0A192F);
  static const Color surfaceColor = Color(0xFF112240);
  static const Color textColor = Color(0xFFCCD6F6);
  static const Color subtitleColor = Color(0xFF8892B0);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: textColor,
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: textColor,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: textColor,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: subtitleColor,
            fontSize: 16,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
} 