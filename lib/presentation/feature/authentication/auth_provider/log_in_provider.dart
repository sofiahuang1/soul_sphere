import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/widget/login_form_content.dart';

class LoginFormProvider extends StatelessWidget {
  const LoginFormProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginFormContent(),
    );
  }
}
