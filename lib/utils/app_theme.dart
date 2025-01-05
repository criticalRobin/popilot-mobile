import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    primaryColor: AppColors.lapislazuli,
    colorScheme: base.colorScheme.copyWith(
      secondary: AppColors.moonstone,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: AppColors.white,
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        color: AppColors.erieblack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.lapislazuli,
      unselectedItemColor: AppColors.erieblack,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: base.textTheme.copyWith(
      bodyLarge: base.textTheme.bodyLarge?.copyWith(
        color: AppColors.erieblack,
      ),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        color: AppColors.erieblack,
      ),
    ),
  );
}
