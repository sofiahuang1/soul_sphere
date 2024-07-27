import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 135, 209, 182),
      Color.fromARGB(255, 187, 127, 219),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(pi / 5),
  );
  static const Color purple = Color.fromARGB(255, 154, 134, 172);
  static const Color white = Colors.white;
  static Color opacityWhite = Colors.white.withOpacity(0.7);
}
