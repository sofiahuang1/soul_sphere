import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppAssets.facebook, width: 40.0, height: 40.0),
          Image.asset(AppAssets.google, width: 40.0, height: 40.0),
          Image.asset(AppAssets.twitter, width: 40.0, height: 40.0),
        ],
      ),
    );
  }
}
