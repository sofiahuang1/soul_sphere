import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';

Widget buildFloatingActionButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 35),
    height: 60,
    width: 60,
    child: FloatingActionButton(
      backgroundColor: AppColors.white,
      elevation: 0,
      onPressed: () => context.push(AppPaths.postScreenPath),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 3, color: AppColors.purple),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.purple,
      ),
    ),
  );
}
