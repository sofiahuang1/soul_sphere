import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_event.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_state.dart';
import 'package:soul_sphere/presentation/widgets/gradient_button.dart';

import 'custom_text_field.dart';

class LoginFormContent extends StatefulWidget {
  const LoginFormContent({super.key});

  @override
  LoginFormContentState createState() => LoginFormContentState();
}

class LoginFormContentState extends State<LoginFormContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _emailController,
                labelText: AppConstants.email,
                errorText: state.emailError,
                onChanged: (email) {
                  context.read<LoginBloc>().add(EmailChanged(email));
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: AppConstants.password,
                errorText: state.passwordError,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                onChanged: (password) {
                  context.read<LoginBloc>().add(PasswordChanged(password));
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GradientButton(
                  text: AppConstants.logIn,
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  },
                ),
              ),
              if (state.isSubmitting) const CircularProgressIndicator(),
              if (state.isSuccess) const Text(AppConstants.logInSuccessful),
              if (state.isFailure) const Text(AppConstants.logInFailed),
            ],
          );
        },
      ),
    );
  }
}
