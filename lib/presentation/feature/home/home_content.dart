import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('HOME')),
    );
  }
}
