import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

class UserHeader extends StatelessWidget {
  final UserEntity user;

  const UserHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 38.0, 18.0, 18.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.opacityWhite,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.22,
                ),
                const Text(
                  'Souler',
                  style: AppFonts.appTitle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 106,
                height: 106,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(user.avatar),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.black,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'User ID:',
                      style: AppFonts.smallBoldText,
                    ),
                    Text(user.id),
                    const SizedBox(height: 18),
                    const Text(
                      'Bio: ',
                      style: AppFonts.smallBoldText,
                    ),
                    Text(user.bio),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
