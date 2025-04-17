import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // Define your custom font styles here



  static TextStyle get displayBold => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
      );

  static TextStyle get display => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      );

  static TextStyle get headline => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      );

  static TextStyle get title => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

  static TextStyle get subtitle => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );

  static TextStyle get body => const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  static TextStyle get label => const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
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
