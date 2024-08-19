// login_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';
import 'package:soul_sphere/presentation/feature/log_in/widget/login_button.dart';
import 'package:soul_sphere/presentation/feature/sign_up/widget/email_field.dart';
import 'package:soul_sphere/presentation/feature/sign_up/widget/password_field.dart';
import 'package:soul_sphere/presentation/feature/sign_up/widget/social_media_buttons.dart';

import 'signup_redirect_row.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Login Failure')),
            );
        } else if (state.isSuccess) {
          context.go(AppPaths.navPaths[0]);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                        context.read<LoginBloc>().add(EmailChanged(email)),
                  ),
                  const SizedBox(height: 26.0),
                  PasswordField(
                    controller: _passwordController,
                    errorText: state.passwordError,
                    onChanged: (password) => context
                        .read<LoginBloc>()
                        .add(PasswordChanged(password)),
                  ),
                  const SizedBox(height: 46.0),
                  LoginButton(
                    isSubmitting: state.isSubmitting,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<LoginBloc>().add(LoginSubmitted(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                      }
                    },
                    buttonText: 'Log In',
                    gradient: AppColors.secondaryGradient,
                  ),
                  const SizedBox(height: 30.0),
                  const SignupRedirectRow(),
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
