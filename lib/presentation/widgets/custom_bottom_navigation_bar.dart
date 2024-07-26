import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IconData> icons;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      height: size.width * 0.160,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: icons.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.024,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () => onTap(index),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == currentIndex ? 0 : size.width * 0.029,
                  right: size.width * 0.0442,
                  left: size.width * 0.0442,
                ),
                width: size.width * 0.128,
                height: index == currentIndex ? size.width * 0.014 : 0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
              Icon(
                icons[index],
                size: size.width * 0.076,
                color: index == currentIndex ? Colors.white : Colors.black,
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
