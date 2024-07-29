import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/sign_up/signup_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/sign_up/signup_event.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/sign_up/signup_state.dart';

import 'custom_text_field.dart';

class SignupFormContent extends StatefulWidget {
  const SignupFormContent({super.key});

  @override
  SignupFormContentState createState() => SignupFormContentState();
}

class SignupFormContentState extends State<SignupFormContent> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _usernameController,
                labelText: 'Username',
                errorText: state.usernameError,
                onChanged: (username) {
                  context.read<SignupBloc>().add(UsernameChanged(username));
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                errorText: state.emailError,
                onChanged: (email) {
                  context.read<SignupBloc>().add(EmailChanged(email));
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
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
                  context.read<SignupBloc>().add(PasswordChanged(password));
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<SignupBloc>().add(SignupSubmitted());
                },
                child: const Text('Signup'),
              ),
              if (state.isSubmitting) const CircularProgressIndicator(),
              if (state.isSuccess) const Text('Signup successful!'),
              if (state.isFailure) const Text('Signup failed!'),
            ],
          );
        },
      ),
    );
  }
}
