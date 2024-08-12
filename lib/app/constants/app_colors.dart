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
      Color.fromARGB(255, 248, 70, 245),
      Color.fromARGB(255, 21, 183, 247),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(pi / 5),
  );

  static const Color purple = Color.fromARGB(255, 164, 100, 221);
  static const Color white = Colors.white;
  static Color opacityWhite = Colors.white.withOpacity(0.7);
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color lightGrey = Colors.grey;
}
