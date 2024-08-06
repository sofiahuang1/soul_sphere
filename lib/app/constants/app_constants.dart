import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/screens.dart';

import '../../domain/model/slide_info.dart';

class AppConstants {
  static const String appName = "Soul Sphere";
  static const String authorName = "Created by Sophia";
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
        'Discover Collections',
        'Explore wide range of stylish clothing options designed to fit every occasion and personal style.',
        'assets/image/float_astro_planet.png'),
    SlideInfo(
        'Fast & Free Shipping',
        'Enjoy fast delivery on all orders across the globe, along with free shipping on purchases over 50 \u{20AC}.',
        'assets/image/laptop_astro.png'),
    SlideInfo(
        'Sustainable Practices',
        'Eco-friendly materials and promote ethical manufacturing processes to minimize our environmental impact.',
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
