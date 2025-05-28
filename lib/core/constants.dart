import 'package:flutter/material.dart';

class AppConstants {
  static const double defaultPadding = 16.0;
  static const double imageHeight = 300.0;
  static const double borderRadius = 12.0;
}

class AppColors {
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF2980B9);
  static const Color background = Color(0xFFF5F5F5);
  static const Color accent = Color(0xFFe67e22);
  static const Color error = Color(0xFFe74c3c);
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color timerRed = Color(0xFFD63031);
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
}
