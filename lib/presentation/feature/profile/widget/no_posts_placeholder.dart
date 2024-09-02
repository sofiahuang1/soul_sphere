import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';

class NoPostsPlaceholder extends StatelessWidget {
  const NoPostsPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: LottieBuilder.asset(
            AppAssets.emptyJson,
            fit: BoxFit.cover,
          ),
        ),
        const Text('No Post Yet....'),
      ],
    );
  }
}
