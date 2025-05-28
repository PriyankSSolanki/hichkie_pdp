import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1565C0);
  static const Color accent = Color(0xFFE53935);
  static const Color error = Color(0xFFD32F2F);
  static const Color background = Color(0xFFF5F5F5);

  // Add these for cinematic hero section
  static const Color darkBackground = Color(0xFF121212);
  static const Color waveColor = Color(0x6600AAFF); // 40% opacity
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
