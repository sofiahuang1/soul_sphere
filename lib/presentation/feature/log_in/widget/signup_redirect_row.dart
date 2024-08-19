import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';

class SignupRedirectRow extends StatelessWidget {
  const SignupRedirectRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New user? ',
          style: TextStyle(color: AppColors.lightGrey),
        ),
        GestureDetector(
          onTap: () {
            context.go(AppPaths.signupPath);
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
