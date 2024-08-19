// sign_up_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_event.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_state.dart';

import 'email_field.dart';
import 'login_redirect_row.dart';
import 'password_field.dart';
import 'sign_up_button.dart';
import 'social_media_buttons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        } else if (state.isSuccess) {
          context.go(AppPaths.navPaths[0]);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EmailField(
                    controller: _emailController,
                    errorText: state.emailError,
                    onChanged: (email) =>
                        context.read<SignupBloc>().add(EmailChanged(email)),
                  ),
                  const SizedBox(height: 26.0),
                  PasswordField(
                    controller: _passwordController,
                    errorText: state.passwordError,
                    onChanged: (password) => context
                        .read<SignupBloc>()
                        .add(PasswordChanged(password)),
                  ),
                  const SizedBox(height: 46.0),
                  SignUpButton(
                    isSubmitting: state.isSubmitting,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<SignupBloc>().add(
                              SignupSubmitted(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 30.0),
                  const LoginRedirectRow(),
                  const SizedBox(height: 40.0),
                  const Divider(thickness: 1.0),
                  const SocialMediaButtons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
