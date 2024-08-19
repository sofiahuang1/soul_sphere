import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class SildeMainColumn extends StatelessWidget {
  const SildeMainColumn({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.titleSize,
    required this.caption,
    required this.captionSize,
  });

  final String imageUrl;
  final String title;
  final double titleSize;
  final String caption;
  final double captionSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          height: 270,
          width: 180,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          caption,
          style: TextStyle(
            fontSize: captionSize,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
