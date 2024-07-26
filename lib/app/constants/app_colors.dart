import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 135, 209, 194),
      Color.fromARGB(255, 219, 127, 199),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(pi / 4),
  );
}
