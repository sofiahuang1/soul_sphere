import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';

class LoginRedirectRow extends StatelessWidget {
  const LoginRedirectRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: AppColors.lightGrey),
        ),
        GestureDetector(
          onTap: () {
            context.go(AppPaths.loginPath);
          },
          child: const Text(
            'Log in',
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
