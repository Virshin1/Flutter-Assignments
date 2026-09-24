import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/dashboard_models.dart';

// ======================================================
// DASHBOARD MOCK DATASET
// ======================================================
class DashboardMockData {
  // Navigation tabs
  static const List<NavItemData> navItems = [
    NavItemData(
      title: 'Overview',
      icon: Icons.dashboard_outlined,
      badgeText: 'Live',
    ),
    NavItemData(
      title: 'Bookmarked',
      icon: Icons.bookmark_border_outlined,
    ),
  ];

  // Category filter tags
  static const List<String> categories = [
    'All',
    'Flutter & Mobile',
    'Full-Stack UI',
    'Cloud Architecture',
    'AI & Data Engine',
    'API Services',
  ];

  // KPI telemetry indicators
  static const List<MetricCardData> metrics = [
    MetricCardData(
      title: 'Active Workspaces',
      value: '24',
      change: '+12.5%',
      isPositive: true,
      icon: Icons.layers_outlined,
      accentColor: AppPalette.primary,
      lightColor: AppPalette.primaryLight,
    ),
    MetricCardData(
      title: 'Tasks Finished',
      value: '188',
      change: '+28.4%',
      isPositive: true,
      icon: Icons.task_alt_outlined,
      accentColor: AppPalette.secondary,
      lightColor: AppPalette.secondaryLight,
    ),
    MetricCardData(
      title: 'Hours Tracked',
      value: '142.5h',
      change: '-3.1%',
      isPositive: false,
      icon: Icons.access_time_outlined,
      accentColor: AppPalette.accent,
      lightColor: AppPalette.accentLight,
    ),
    MetricCardData(
      title: 'Health Score',
      value: '98.6%',
      change: '+4.2%',
      isPositive: true,
      icon: Icons.auto_graph_outlined,
      accentColor: AppPalette.success,
      lightColor: AppPalette.successLight,
    ),
  ];

  // Project cards catalog
  static const List<ProjectCardData> initialProjects = [
    ProjectCardData(
      id: 'PRJ-01',
      title: 'Cross-App Multiplatform Suite',
      category: 'Flutter & Mobile',
      progress: 0.85,
      dueDate: 'Tomorrow',
      teamMembers: 4,
      icon: Icons.phone_android_rounded,
    ),
    ProjectCardData(
      id: 'PRJ-02',
      title: 'Design System & Token Library',
      category: 'Full-Stack UI',
      progress: 0.60,
      dueDate: 'In 3 days',
      teamMembers: 3,
      icon: Icons.palette_outlined,
    ),
    ProjectCardData(
      id: 'PRJ-03',
      title: 'Serverless Real-Time Sync Engine',
      category: 'Cloud Architecture',
      progress: 0.40,
      dueDate: 'Next week',
      teamMembers: 5,
      icon: Icons.cloud_sync_outlined,
    ),
    ProjectCardData(
      id: 'PRJ-04',
      title: 'Vision AI Inference Pipeline',
      category: 'AI & Data Engine',
      progress: 0.92,
      dueDate: 'Oct 14',
      teamMembers: 2,
      icon: Icons.psychology_outlined,
    ),
    ProjectCardData(
      id: 'PRJ-05',
      title: 'GraphQL Gateway & Auth Proxy',
      category: 'API Services',
      progress: 0.75,
      dueDate: 'Oct 18',
      teamMembers: 3,
      icon: Icons.api_outlined,
    ),
    ProjectCardData(
      id: 'PRJ-06',
      title: 'Adaptive Dashboard Framework',
      category: 'Flutter & Mobile',
      progress: 0.50,
      dueDate: 'Oct 22',
      teamMembers: 4,
      icon: Icons.devices_outlined,
    ),
  ];

  // Recent timeline events
  static const List<ActivityItemData> activities = [
    ActivityItemData(
      title: 'Sprint 4 Released',
      description: 'Production build 1.4.0 verified',
      timestamp: '10m ago',
      initials: 'VK',
      avatarColor: AppPalette.primary,
      statusIcon: Icons.rocket_launch_outlined,
    ),
    ActivityItemData(
      title: 'API Schema Updated',
      description: 'Merged PR #42 in cross-service',
      timestamp: '42m ago',
      initials: 'AS',
      avatarColor: AppPalette.secondary,
      statusIcon: Icons.merge_type_rounded,
    ),
    ActivityItemData(
      title: 'Widget Test Suite Pass',
      description: '100% assertions green on CI',
      timestamp: '2h ago',
      initials: 'CI',
      avatarColor: AppPalette.success,
      statusIcon: Icons.check_circle_outline,
    ),
    ActivityItemData(
      title: 'Security Audit Cleared',
      description: 'Zero high severity vulnerabilities',
      timestamp: '5h ago',
      initials: 'SA',
      avatarColor: AppPalette.accent,
      statusIcon: Icons.shield_outlined,
    ),
  ];
}
