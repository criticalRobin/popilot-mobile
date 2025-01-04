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
      backgroundColor: AppColors.lapislazuli,
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
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
