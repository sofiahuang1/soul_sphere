import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/di/service_locator.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_event.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_state.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/header_wave_gradient.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final prefs = getIt<SharedPreferences>();
          final userId = prefs.getString('userId') ?? '';
          return getIt<ProfileBloc>()..add(LoadProfile(userId));
        },
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HeaderWaveGradient(),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.black,
                                  width: 3.0,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(state.user.avatar),
                                radius: 45,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.user.email,
                              style: AppFonts.mediumText,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'UserID: ${state.user.id}',
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${state.user.followingCount}',
                                      style: AppFonts.mediumText,
                                    ),
                                    const Text('Following'),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  children: [
                                    Text(
                                      '${state.user.followersCount}',
                                      style: AppFonts.mediumText,
                                    ),
                                    const Text('Followers'),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  children: [
                                    Text(
                                      '${state.user.postCount}',
                                      style: AppFonts.mediumText,
                                    ),
                                    const Text('Posts'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  55.0, 48.0, 40.0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bio: ',
                                    style: AppFonts.mediumText,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.lightGrey,
                                        width: 1.0, // Ancho del borde
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(22.0),
                                    child: Text(
                                      state.user.bio,
                                      style: AppFonts.smallText,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (state is ProfileError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text('No profile data'));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 240,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: LottieBuilder.asset(
                    AppAssets.emptyJson,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text('No Post Yet....'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
