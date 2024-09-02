import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class CustomAppBarForUserDetails extends StatelessWidget {
  const CustomAppBarForUserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.opacityWhite,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        const Text(
          'Souler',
          style: AppFonts.appTitle,
        ),
      ],
    );
  }
}
