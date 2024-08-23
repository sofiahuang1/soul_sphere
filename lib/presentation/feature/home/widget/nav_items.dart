import 'package:flutter/material.dart';
import 'package:soul_sphere/presentation/screens.dart';
import 'package:soul_sphere/presentation/widgets/nav_model.dart';

List<NavModel> getNavItems(
    GlobalKey<NavigatorState> homeNavKey,
    GlobalKey<NavigatorState> momentNavKey,
    GlobalKey<NavigatorState> chatNavKey,
    GlobalKey<NavigatorState> profileNavKey) {
  return [
    NavModel(
      page: const HomeContent(),
      navKey: homeNavKey,
    ),
    NavModel(
      page: const MomentScreen(),
      navKey: momentNavKey,
    ),
    NavModel(
      page: const AllChatScreen(),
      navKey: chatNavKey,
    ),
    NavModel(
      page: const ProfileScreen(),
      navKey: profileNavKey,
    ),
  ];
}
