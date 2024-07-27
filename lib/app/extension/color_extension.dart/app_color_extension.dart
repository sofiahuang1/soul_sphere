import 'package:flutter/material.dart';

extension AppColorExtension on BuildContext {
  /*
 //change color if mobile change mode
  Color get detailContainerColor {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? const Color.fromARGB(255, 252, 252, 252).withOpacity(0.7)
        : Colors.black.withOpacity(0.8);
  }

  Color get detailBorderColor {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? Colors.black.withOpacity(0.8)
        : Colors.white;
  }

  Color get settingContainerColor {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

  Color get settingTextColor {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? const Color.fromARGB(255, 28, 28, 28)
        : const Color.fromARGB(255, 148, 147, 147);
  }

  Color get languageTextColor {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? const Color.fromARGB(255, 28, 28, 28)
        : const Color.fromARGB(255, 237, 236, 236);
  }

  */

  Color get detailContainerColor {
    return Theme.of(this).brightness == Brightness.light
        ? const Color.fromARGB(255, 252, 252, 252).withOpacity(0.7)
        : Colors.black.withOpacity(0.8);
  }

  Color get detailBorderColor {
    return Theme.of(this).brightness == Brightness.light
        ? Colors.black.withOpacity(0.8)
        : Colors.white;
  }

  Color get settingContainerColor {
    return Theme.of(this).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

  Color get settingTextColor {
    return Theme.of(this).brightness == Brightness.light
        ? const Color.fromARGB(255, 28, 28, 28)
        : const Color.fromARGB(255, 148, 147, 147);
  }

  Color get languageTextColor {
    return Theme.of(this).brightness == Brightness.light
        ? const Color.fromARGB(255, 28, 28, 28)
        : const Color.fromARGB(255, 237, 236, 236);
  }
}
