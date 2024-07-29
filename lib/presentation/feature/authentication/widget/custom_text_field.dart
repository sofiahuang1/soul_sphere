import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final IconButton? suffixIcon;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.suffixIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
    );
  }
}
