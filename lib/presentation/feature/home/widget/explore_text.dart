import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';

class ExploreText extends StatelessWidget {
  const ExploreText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 18, 18, 8),
      child: Text(
        AppConstants.explore,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
