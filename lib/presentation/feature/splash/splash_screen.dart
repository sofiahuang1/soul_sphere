import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/data/datasource/local_data_source/local_datasource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<double> _titleFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final localDataSource = GetIt.instance<LocalDataSource>();
    final isFirst = await localDataSource.getIsFirst();
    final userId = await localDataSource.getUserId();

    Future.delayed(const Duration(milliseconds: 4000), () {
      if (isFirst) {
        context.go(AppPaths.onBoardingPath);
      } else if (userId != null) {
        context.go(AppPaths.navPaths[0]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            AnimatedBuilder(
              animation: _logoScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Image.asset(AppAssets.logoAsset),
                );
              },
            ),
            FadeTransition(
              opacity: _titleFadeAnimation,
              child: const Text(
                AppConstants.appName,
                style: AppFonts.appTitle,
              ),
            ),
            const Spacer(),
            const Text(AppConstants.authorName),
            const SizedBox(height: 85),
          ],
        ),
      ),
    );
  }
}
