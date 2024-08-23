import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 70, 248, 183),
      Color.fromARGB(255, 185, 72, 246),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(pi / 5),
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 240, 157, 230),
      Color.fromARGB(255, 65, 111, 235),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(pi / 5),
  );
  static final Color grey = Colors.grey[700]!;
  static const Color purple = Color.fromARGB(255, 172, 118, 219);
  static const Color white = Colors.white;
  static Color opacityWhite = Colors.white.withOpacity(0.7);
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color lightGrey = Colors.grey;
  static const Color lightRed = Color.fromARGB(255, 241, 127, 118);
  static Color opacityGrey = const Color.fromARGB(255, 213, 212, 212);
  static const Color scaleColor = Color(0xFFE9E9E9);
  static const Color indicatorColor = Color(0xFF3995FF);
  static const Color scaleTextColor = Color(0xFF8E99A0);

  static const Color brightPurple = Color.fromARGB(255, 201, 169, 221);
  static const Color brightGreen = Color.fromARGB(255, 191, 250, 212);
  static const Color brightBlue = Color.fromARGB(255, 180, 240, 250);
  static const Color brightLila = Color.fromARGB(255, 199, 195, 248);
}
