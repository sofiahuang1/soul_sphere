import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class MomentScreen extends StatelessWidget {
  const MomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: AppConstants.moment,
      ),
      body: Center(
        child: Text('MOMENT'),
      ),
    );
  }
}
