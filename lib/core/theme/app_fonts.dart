import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle get headline => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      );

  static TextStyle get body => const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  static TextStyle get labelBold => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  static TextStyle get caption => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        color: Colors.grey,
      );

  // You can even make dark/light aware:
  static TextStyle coloredHeadline(Brightness brightness) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: brightness == Brightness.dark ? Colors.white : Colors.black,
      );

  static TextTheme getAppTextTheme(Brightness brightness) {
    // Base Poppins fallback
    final fallbackTextTheme = Typography.material2021().black.apply(
          fontFamily: 'Poppins',
          bodyColor:
              brightness == Brightness.dark ? Colors.white : Colors.black,
        );

    try {
      // Try BungeeSpice (GoogleFonts or your own logic)
      final bungeeTextTheme = GoogleFonts.poppinsTextTheme();

      // Merge with fallback for missing styles
      return bungeeTextTheme.merge(fallbackTextTheme);
    } catch (e) {
      // Always fallback to Poppins
      return fallbackTextTheme;
    }
  }
}
