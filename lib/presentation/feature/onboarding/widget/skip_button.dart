import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 25,
      top: 70,
      child: TextButton(
        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.purple,
          ),
        ),
        onPressed: () => context.go(AppPaths.authPath),
      ),
    );
  }
}
