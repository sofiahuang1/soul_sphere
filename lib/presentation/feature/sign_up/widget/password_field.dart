import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final void Function(String) onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    this.errorText,
    required this.onChanged,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.lightGrey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      obscureText: _obscurePassword,
    );
  }
}
