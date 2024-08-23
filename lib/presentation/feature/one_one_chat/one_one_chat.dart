import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/widget/user_loader.dart';

class OneOneChat extends StatelessWidget {
  const OneOneChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserLoader(),
    );
  }
}
