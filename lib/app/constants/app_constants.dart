import 'package:flutter/material.dart';
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
    const ChatScreen(),
    const ProfileScreen(),
  ];

  static final List<IconData> navIcons = [
    Icons.home_rounded,
    Icons.timelapse_rounded,
    Icons.chat_bubble_rounded,
    Icons.person,
  ];
}
