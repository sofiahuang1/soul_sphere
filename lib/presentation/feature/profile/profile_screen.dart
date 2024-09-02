import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sphere/app/di/service_locator.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_event.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/no_posts_placeholder.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final prefs = getIt<SharedPreferences>();
        final userId = prefs.getString('userId') ?? '';
        return getIt<ProfileBloc>()..add(LoadProfile(userId));
      },
      child: const Scaffold(
        body: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 240),
            NoPostsPlaceholder(),
          ],
        ),
      ),
    );
  }
}
