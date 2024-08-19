import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/router/app_paths.dart';

import '../../../../app/constants/app_colors.dart';
import '../../../../app/constants/app_constants.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: FilledButton(
        onPressed: () => context.go(AppPaths.authPath),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.purple),
        ),
        child: const Text(
          AppConstants.start,
          style: AppFonts.onBoardingText,
        ),
      ),
    );
  }
}
