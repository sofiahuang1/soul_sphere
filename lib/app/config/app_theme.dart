import 'package:flutter/material.dart';
import 'package:soul_sphere/app/extension/theme_extension.dart/custom_themedata.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData().customDarkTheme
        : ThemeData().customLightTheme;
  }
}
