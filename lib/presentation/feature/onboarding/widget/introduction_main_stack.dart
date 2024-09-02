import 'package:flutter/material.dart';

import 'bottom_element_positioned.dart';
import 'intro_page_view.dart';
import 'skip_button.dart';

class IntroductionMainStack extends StatelessWidget {
  const IntroductionMainStack({
    super.key,
    required this.pageViewController,
    required this.currentPage,
    required this.endReached,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final PageController pageViewController;
  final int currentPage;
  final bool endReached;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroPageView(
          pageViewController: pageViewController,
        ),
        const SkipButton(),
        BottomElementPositioned(
            currentPage: currentPage,
            pageViewController: pageViewController,
            endReached: endReached,
            animationController: _animationController),
      ],
    );
  }
}
