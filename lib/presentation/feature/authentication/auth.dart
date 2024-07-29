import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/feature/authentication/widget/login_form.dart';
import 'package:soul_sphere/presentation/feature/authentication/widget/signup_form_content.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

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
              child: const DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      dividerHeight: 0,
                      tabs: [
                        Tab(text: 'Signup'),
                        Tab(text: 'Login'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SignupFormContent(),
                          LoginForm(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
