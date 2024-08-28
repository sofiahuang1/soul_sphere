import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/domain/model/card_item.dart';
import 'package:soul_sphere/presentation/screens.dart';

import '../../domain/model/slide_info.dart';

class AppConstants {
  static const String appName = "Soul Sphere";
  static const String authorName = "Created by Sophia";
  static const String skip = "Skip";
  static const String start = "Start";
  static const String username = "Username";
  static const String email = "Email";
  static const String password = "Password";
  static const String signUp = "Sign up";
  static const String signUpSuccessful = "Sign up successful!";
  static const String signUpFailed = "Sign up failed!  Verify all fields";
  static const String usernameEmpty = "Username cannot be empty";
  static const String emailEmpty = "Email cannot be empty";
  static const String passwordEmpty = "Password cannot be empty";
  static const String logIn = "Log in";
  static const String logInSuccessful = "Log in successful!";
  static const String logInFailed = "Log in failed!  Verify all fields";
  static const String defaultBio =
      'Living, learning, and sharing. Let\'s inspire each other!';

  static const String explore = "Scroll and Explore";
  static const String post = "Post";
  static const String moment = "Moment";
  static const String chats = "Chats";
  static const String settings = "Settings";

  static final slides = <SlideInfo>[
    SlideInfo(
        'Uncover Real Connections',
        'Engage in conversations without the pressure of appearances. Our platform encourages authentic interactions based on who you are, not what you look like.',
        'assets/image/float_astro_planet.png'),
    SlideInfo(
        'Dynamic Chat Rooms',
        'Join chat rooms tailored to your interests. From tech discussions to hobby groups, find your niche and meet like-minded individuals.',
        'assets/image/laptop_astro.png'),
    SlideInfo(
        'Interactive Forums',
        'Post, comment, and debate in interactive forums. Share your thoughts, ask questions, and get involved in community-driven discussions.',
        'assets/image/posture_astro.png'),
  ];

  static final List<Widget> navScreens = [
    const HomeContent(),
    const MomentScreen(),
    const AllChatScreen(),
    const ProfileScreen(),
  ];

  static final List<IconData> navIcons = [
    Icons.home_rounded,
    Icons.timelapse_rounded,
    Icons.chat_bubble_rounded,
    Icons.person,
  ];

  static List<double> centers = [
    0.5,
    0.35,
    0.65,
    0.35,
    0.2,
    0.5,
    0.65,
    0.35,
    0.65,
    0.8,
  ];

  static final List<CardItem> cardItems = [
    CardItem(AppAssets.randomChat, 'Random Chat', AppPaths.oneOneChatPath,
        AppColors.brightGreen),
    CardItem(AppAssets.interestGroups, 'Interest Groups',
        AppPaths.interestGroupPath, AppColors.brightLila),
    CardItem(AppAssets.oneOneVoice, '1-on-1 Voice', AppPaths.oneOneVoicePath,
        AppColors.brightPurple),
    CardItem(AppAssets.themedRooms, 'Themed Rooms', AppPaths.themedRoomPath,
        AppColors.brightBlue),
  ];
}
