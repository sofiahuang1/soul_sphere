import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_event.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) => GetIt.instance<SignUpBloc>(),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        } else if (state.status == SignUpStatus.submissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Column(
        children: [
          TextField(
            onChanged: (email) =>
                context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            onChanged: (password) =>
                context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => context.read<SignUpBloc>().add(SignUpSubmitted()),
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
