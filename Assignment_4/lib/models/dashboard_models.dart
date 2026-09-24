import 'package:flutter/material.dart';

// ======================================================
// KPI METRIC ITEM MODEL
// ======================================================
class MetricCardData {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color accentColor;
  final Color lightColor;

  const MetricCardData({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.accentColor,
    required this.lightColor,
  });
}

// ======================================================
// PROJECT REPOSITORY ITEM MODEL
// ======================================================
class ProjectCardData {
  final String id;
  final String title;
  final String category;
  final double progress; // 0.0 to 1.0
  final String dueDate;
  final int teamMembers;
  final IconData icon;

  const ProjectCardData({
    required this.id,
    required this.title,
    required this.category,
    required this.progress,
    required this.dueDate,
    required this.teamMembers,
    required this.icon,
  });

  String get progressPercentage => '${(progress * 100).toInt()}%';
}

// ======================================================
// ACTIVITY ITEM MODEL
// ======================================================
class ActivityItemData {
  final String title;
  final String description;
  final String timestamp;
  final String initials;
  final Color avatarColor;
  final IconData statusIcon;

  const ActivityItemData({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.initials,
    required this.avatarColor,
    required this.statusIcon,
  });
}

// ======================================================
// NAVIGATION ITEM MODEL
// ======================================================
class NavItemData {
  final String title;
  final IconData icon;
  final String? badgeText;

  const NavItemData({
    required this.title,
    required this.icon,
    this.badgeText,
  });
}
