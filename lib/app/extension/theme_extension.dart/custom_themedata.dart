import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomThemeData on ThemeData {
  ThemeData get customLightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: GoogleFonts.loraTextTheme().apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }

  ThemeData get customDarkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: GoogleFonts.loraTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }
}
