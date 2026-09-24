import 'package:flutter/material.dart';

/// AppPalette defines the design tokens, harmonious color scheme,
/// and styling constants for the Todo Application.
///
/// Follows the visual hierarchy and styling conventions established in the
/// workspace (such as in `dashboard/` and `Assignments/profile/`).
class AppPalette {
  // Brand & Accent Colors
  static const Color primary = Color(0xFF4F46E5); // Rich Indigo Accent
  static const Color primaryLight = Color(0xFFEEF2FF); // Soft Indigo Tint
  static const Color primaryDark = Color(0xFF3730A3); // Deep Indigo

  static const Color secondary = Color(0xFF0D9488); // Ocean Teal Accent
  static const Color secondaryLight = Color(0xFFCCFBF1); // Soft Teal Tint

  static const Color success = Color(0xFF10B981); // Emerald Green Accent
  static const Color successLight = Color(0xFFD1FAE5); // Soft Green Tint

  static const Color warning = Color(0xFFF59E0B); // Amber Alert
  static const Color warningLight = Color(0xFFFEF3C7); // Soft Amber Tint

  static const Color danger = Color(0xFFEF4444); // Coral Red Accent
  static const Color dangerLight = Color(0xFFFEE2E2); // Soft Red Tint

  // Neutral Background & Surface Colors
  static const Color background = Color(0xFFF8FAFC); // Slate-50 Page Background
  static const Color surface = Color(0xFFFFFFFF); // Pure White Card Surface
  static const Color cardBorder = Color(0xFFE2E8F0); // Slate-200 Subtle Border
  static const Color divider = Color(0xFFF1F5F9); // Slate-100 Divider

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate-900 High Contrast
  static const Color textSecondary = Color(0xFF64748B); // Slate-500 Body Subtext
  static const Color textMuted = Color(0xFF94A3B8); // Slate-400 Subtle Hint

  // Priority Colors
  static const Color priorityLow = Color(0xFF10B981); // Green
  static const Color priorityLowBg = Color(0xFFD1FAE5);
  static const Color priorityMedium = Color(0xFFF59E0B); // Amber
  static const Color priorityMediumBg = Color(0xFFFEF3C7);
  static const Color priorityHigh = Color(0xFFEF4444); // Red
  static const Color priorityHighBg = Color(0xFFFEE2E2);

  // Category Colors
  static const Color catPersonal = Color(0xFF8B5CF6); // Purple
  static const Color catWork = Color(0xFF2563EB); // Blue
  static const Color catStudy = Color(0xFF0D9488); // Teal
  static const Color catHealth = Color(0xFFEC4899); // Pink

  // Subtle Card Shadow
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
}
