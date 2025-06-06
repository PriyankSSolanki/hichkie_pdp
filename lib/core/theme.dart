import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.title,
    bodyMedium: AppTextStyles.subtitle,
    bodySmall: const TextStyle(fontSize: 14),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.accent,
    error: AppColors.error,
  ),
);
