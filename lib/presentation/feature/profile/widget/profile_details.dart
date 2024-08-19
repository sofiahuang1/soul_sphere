import 'package:flutter/material.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_state.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/bio_section.dart';
import 'package:soul_sphere/presentation/feature/profile/widget/stats_row.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key, required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
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
        StatsRow(
          followingCount: state.user.followingCount,
          followersCount: state.user.followersCount,
          postCount: state.user.postCount,
        ),
        const SizedBox(height: 25),
        BioSection(bio: state.user.bio),
      ],
    );
  }
}
