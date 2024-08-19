import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_state.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/header_wave_gradient.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/profile_details.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                return ProfileDetails(state: state);
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No profile data'));
            },
          ),
        ),
      ],
    );
  }
}
