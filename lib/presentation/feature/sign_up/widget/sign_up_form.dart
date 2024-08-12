import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_event.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_state.dart';

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
                  TextFormField(
                    controller: _emailController,
                    onChanged: (email) =>
                        context.read<SignupBloc>().add(EmailChanged(email)),
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
                        .read<SignupBloc>()
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
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: ElevatedButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<SignupBloc>()
                                    .add(SignupSubmitted());
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        backgroundColor: AppColors.transparent,
                        shadowColor: AppColors.transparent,
                      ),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.white),
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(color: AppColors.white),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have account ? ',
                        style: TextStyle(color: AppColors.lightGrey),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppPaths.loginPath);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
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
