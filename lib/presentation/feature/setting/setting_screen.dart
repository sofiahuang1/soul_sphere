import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: AppConstants.settings),
      body: Center(
        child: Text('setting Screen'),
      ),
    );
  }
}
