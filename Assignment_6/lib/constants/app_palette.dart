import 'package:flutter/material.dart';

/// AppPalette defines design tokens, color constants, and aesthetic styles
/// for the Product Listing application.
///
/// Follows established workspace conventions from `dashboard/` and `todo_app/`.
class AppPalette {
  // Brand & Accent Colors
  static const Color primary = Color(0xFF4F46E5); // Rich Indigo Accent
  static const Color primaryLight = Color(0xFFEEF2FF); // Soft Indigo Tint
  static const Color primaryDark = Color(0xFF3730A3); // Deep Indigo

  static const Color secondary = Color(0xFF0D9488); // Ocean Teal Accent
  static const Color secondaryLight = Color(0xFFCCFBF1); // Soft Teal Tint

  static const Color accent = Color(0xFFF59E0B); // Warm Amber Accent
  static const Color accentLight = Color(0xFFFEF3C7); // Soft Amber Tint

  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color successLight = Color(0xFFD1FAE5); // Soft Green Tint

  static const Color danger = Color(0xFFEF4444); // Coral Red / Discount Badge
  static const Color dangerLight = Color(0xFFFEE2E2); // Soft Red Tint

  // Star & Badge Colors
  static const Color starFilled = Color(0xFFF59E0B); // Amber star
  static const Color starEmpty = Color(0xFFCBD5E1); // Slate-300
  static const Color favoriteActive = Color(0xFFEF4444); // Crimson Heart

  // Neutral Background & Surface Colors
  static const Color background = Color(0xFFF8FAFC); // Slate-50 Page Background
  static const Color surface = Color(0xFFFFFFFF); // Pure White Card Surface
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate-100 Container
  static const Color cardBorder = Color(0xFFE2E8F0); // Slate-200 Subtle Border
  static const Color divider = Color(0xFFF1F5F9); // Slate-100 Divider

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate-900 High Contrast
  static const Color textSecondary = Color(0xFF64748B); // Slate-500 Body Subtext
  static const Color textMuted = Color(0xFF94A3B8); // Slate-400 Subtle Metadata

  // Category Accent Colors
  static const Color catElectronics = Color(0xFF3B82F6); // Blue
  static const Color catElectronicsBg = Color(0xFFEFF6FF);
  static const Color catAudio = Color(0xFF8B5CF6); // Purple
  static const Color catAudioBg = Color(0xFFF5F3FF);
  static const Color catWearables = Color(0xFF0D9488); // Teal
  static const Color catWearablesBg = Color(0xFFCCFBF1);
  static const Color catFootwear = Color(0xFFF97316); // Orange
  static const Color catFootwearBg = Color(0xFFFFF7ED);
  static const Color catAccessories = Color(0xFFEC4899); // Pink
  static const Color catAccessoriesBg = Color(0xFFFDF2F8);

  // Card & Container Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get floatingShadow => [
        BoxShadow(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];
}
