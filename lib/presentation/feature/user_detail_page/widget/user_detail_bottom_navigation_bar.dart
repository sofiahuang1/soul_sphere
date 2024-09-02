import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/presentation/feature/user_detail_page/widget/gradient_button.dart';

class UserDetailBottomNavigationBar extends StatelessWidget {
  final UserEntity user;
  final String currentUserId;

  const UserDetailBottomNavigationBar(
      {super.key, required this.user, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: GradientButton(
                text: 'Follow',
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: GradientButton(
                text: 'Chat',
                onPressed: () {
                  context.push(
                    AppPaths.chatScreenPath,
                    extra: {
                      'currentUserId': currentUserId,
                      'randomUser': user,
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
