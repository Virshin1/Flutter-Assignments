import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Deep Sapphire & Tech Violet
  static const Color primary = Color(0xFF2563EB); // Royal Blue
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFFEFF6FF);
  
  // Accent & Status Colors
  static const Color online = Color(0xFF10B981); // Emerald Green
  static const Color onlineLight = Color(0xFFECFDF5);
  
  static const Color cached = Color(0xFFF59E0B); // Amber Yellow
  static const Color cachedLight = Color(0xFFFFFBEB);
  
  static const Color error = Color(0xFFEF4444); // Crimson Red
  static const Color errorLight = Color(0xFFFEF2F2);
  
  // Surfaces & Backgrounds
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Colors.white;
  static const Color cardBorder = Color(0xFFE2E8F0);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
