import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';

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
                  TextFormField(
                    controller: _emailController,
                    onChanged: (email) =>
                        context.read<LoginBloc>().add(EmailChanged(email)),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: state.emailError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (password) => context
                        .read<LoginBloc>()
                        .add(PasswordChanged(password)),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: state.passwordError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 46.0),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.secondaryGradient,
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: ElevatedButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<LoginBloc>().add(LoginSubmitted(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ));
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white),
                            )
                          : const Text(
                              'Log In',
                              style: TextStyle(color: AppColors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New user? ',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppPaths.signupPath);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  const Divider(thickness: 1.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(AppAssets.facebook,
                            width: 40.0, height: 40.0),
                        Image.asset(AppAssets.google,
                            width: 40.0, height: 40.0),
                        Image.asset(AppAssets.twitter,
                            width: 40.0, height: 40.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
