import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
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
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.purple),
          padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
        ),
        onPressed: () => context.go(AppPaths.signupPath),
        child: const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(
            AppConstants.skip,
            style: AppFonts.onBoardingText,
          ),
        ),
      ),
    );
  }
}
