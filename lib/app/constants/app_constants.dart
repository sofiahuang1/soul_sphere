import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/screens.dart';

class AppConstants {
  static const String appName = "Soul Sphere";
  static const String authorName = "Created by Sophia";
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
