import 'package:flutter/material.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.followingCount,
    required this.followersCount,
    required this.postCount,
  });

  final int followingCount;
  final int followersCount;
  final int postCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatColumn(followingCount, 'Following'),
        const SizedBox(width: 30),
        _buildStatColumn(followersCount, 'Followers'),
        const SizedBox(width: 30),
        _buildStatColumn(postCount, 'Posts'),
      ],
    );
  }

  Column _buildStatColumn(int count, String label) {
    return Column(
      children: [
        Text(
          '$count',
          style: AppFonts.mediumText,
        ),
        Text(label),
      ],
    );
  }
}
