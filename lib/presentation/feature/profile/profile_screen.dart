import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/header_curve_gradient.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderCurveGradient(),
          Expanded(
            child: Center(child: Text('Profile')),
          ),
        ],
      ),
    );
  }
}
