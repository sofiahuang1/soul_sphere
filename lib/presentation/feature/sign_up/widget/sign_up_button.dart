import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class SignUpButton extends StatelessWidget {
  final bool isSubmitting;
  final void Function()? onPressed;

  const SignUpButton({
    super.key,
    required this.isSubmitting,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
        ),
        child: isSubmitting
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              )
            : const Text(
                'Sign Up',
                style: TextStyle(color: AppColors.white),
              ),
      ),
    );
  }
}
