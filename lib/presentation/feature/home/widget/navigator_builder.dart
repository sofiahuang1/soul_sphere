import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/widgets/nav_model.dart';

Navigator buildNavigator(NavModel page) {
  return Navigator(
    key: page.navKey,
    onGenerateInitialRoutes: (navigator, initialRoute) {
      return [MaterialPageRoute(builder: (context) => page.page)];
    },
  );
}
