import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';
import 'package:soul_sphere/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    final path = AppPaths.navPaths[index];
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
        icons: AppConstants.navIcons,
      ),
      body: AppConstants.navScreens[_currentIndex],
    );
  }
}
