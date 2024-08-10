import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_event.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_state.dart';
import 'package:soul_sphere/presentation/feature/sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) => GetIt.instance<LoginBloc>(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status == LoginStatus.submissionSuccess) {
          // Navigate to home or another screen
        }
      },
      child: Column(
        children: [
          TextField(
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email)),
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()),
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              );
            },
            child: const Text('Don\'t have an account? Sign Up'),
          ),
        ],
      ),
    );
  }
}
