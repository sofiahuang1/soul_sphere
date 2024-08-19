import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class LoginButton extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onPressed;
  final String buttonText;
  final Gradient gradient;

  const LoginButton({
    super.key,
    required this.isSubmitting,
    required this.onPressed,
    required this.buttonText,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isSubmitting
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              )
            : Text(
                buttonText,
                style: const TextStyle(color: AppColors.white),
              ),
      ),
    );
  }
}
