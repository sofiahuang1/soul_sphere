import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/sign_up/signup_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/widget/signup_form_content.dart';

class SignupFormProvider extends StatelessWidget {
  const SignupFormProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
      child: const SignupFormContent(),
    );
  }
}
