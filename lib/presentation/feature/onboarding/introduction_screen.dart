import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';

import 'widget/introduction_main_stack.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});
  static const String name = 'introduction_screen';

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  final PageController pageViewController = PageController();

  bool endReached = false;
  int currentPage = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;

      currentPage = page.round();
      setState(() {});
      if (!endReached && page >= (AppConstants.slides.length - 1.5)) {
        endReached = true;
        setState(() {});
        _animationController.forward();
      } else if (endReached && page < (AppConstants.slides.length - 1.5)) {
        endReached = false;
        setState(() {});
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IntroductionMainStack(
          pageViewController: pageViewController,
          currentPage: currentPage,
          endReached: endReached,
          animationController: _animationController),
    );
  }
}
