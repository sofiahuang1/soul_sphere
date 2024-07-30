import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/app/config/app_theme.dart';
import 'package:soul_sphere/app/router/app_routers.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/log_in/log_in_bloc.dart';
import 'package:soul_sphere/presentation/feature/authentication/auth_bloc/sign_up/signup_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignupBloc(),
        ),
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(Brightness.light),
      ),
    );
  }
}
