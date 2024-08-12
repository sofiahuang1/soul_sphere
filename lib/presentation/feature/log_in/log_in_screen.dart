import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/widget/log_in_form.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: MediaQuery.sizeOf(context).height - 350,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Image.asset(
                AppAssets.authBackAsset,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 300,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocProvider(
                  create: (_) => GetIt.instance<LoginBloc>(),
                  child: const LogInForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
