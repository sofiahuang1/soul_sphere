import 'package:flutter/material.dart';

import 'bottom_indicators.dart';
import 'start_button.dart';

class BottomElementPositioned extends StatelessWidget {
  const BottomElementPositioned({
    super.key,
    required this.currentPage,
    required this.pageViewController,
    required this.endReached,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final int currentPage;
  final PageController pageViewController;
  final bool endReached;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 30,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPage > 0)
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () => pageViewController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            )
          else
            const SizedBox(width: 48),
          BottomIndicators(currentPage: currentPage),
          if (endReached)
            StartButton(animationController: _animationController)
          else
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () => pageViewController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
        ],
      ),
    );
  }
}
