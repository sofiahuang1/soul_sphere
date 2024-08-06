import 'package:flutter/material.dart';
import 'package:soul_sphere/app/config/app_theme.dart';
import 'package:soul_sphere/app/router/app_routers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(Brightness.light),
    );
  }
}
