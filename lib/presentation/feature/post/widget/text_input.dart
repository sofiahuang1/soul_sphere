import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: const InputDecoration(hintText: 'What’s on your mind?'),
    );
  }
}
