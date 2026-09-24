import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/dashboard_models.dart';
import '../data/dashboard_mock_data.dart';
import '../widgets/section_heading.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/header_search_bar.dart';
import '../widgets/kpi_metrics_grid.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/project_catalog_grid.dart';
import '../widgets/activity_stream_list.dart';
import '../widgets/right_side_panel.dart';
import 'project_detail_screen.dart';

// ======================================================
// DASHBOARD SCREEN (Simple Responsive Multi-Section Hub)
// ======================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Navigation & Filter States
  int _selectedNavIndex = 0;
  String _selectedCategory = 'All';
  final Set<String> _bookmarkedProjectIds = {'PRJ-01', 'PRJ-04'};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Toggle bookmark callback
  void _toggleBookmark(String projectId) {
    setState(() {
      if (_bookmarkedProjectIds.contains(projectId)) {
        _bookmarkedProjectIds.remove(projectId);
      } else {
        _bookmarkedProjectIds.add(projectId);
      }
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _bookmarkedProjectIds.contains(projectId)
              ? 'Added to bookmarked projects'
              : 'Removed from bookmarks',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Navigate to clean Project Detail Screen
  void _openProjectDetails(ProjectCardData project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(
          project: project,
          isBookmarked: _bookmarkedProjectIds.contains(project.id),
          onToggleBookmark: () => _toggleBookmark(project.id),
        ),
      ),
    );
  }

  // Computed filtered projects based on tab, category, and search query
  List<ProjectCardData> get _filteredProjects {
    return DashboardMockData.initialProjects.where((project) {
      // If bookmarked tab is selected
      if (_selectedNavIndex == 1 && !_bookmarkedProjectIds.contains(project.id)) {
        return false;
      }

      // Category match
      final bool matchesCategory = _selectedCategory == 'All' ||
          project.category == _selectedCategory;

      // Keyword search match
      final String query = _searchController.text.trim().toLowerCase();
      final bool matchesSearch = query.isEmpty ||
          project.title.toLowerCase().contains(query) ||
          project.category.toLowerCase().contains(query) ||
          project.id.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // ======================================================
    // RESPONSIVE SCREEN METRICS (MediaQuery Breakpoints)
    // ======================================================
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isDesktop = screenWidth >= 1024;

    return Scaffold(
      backgroundColor: AppPalette.background,

      // ==========================================
      // MOBILE / TABLET APP BAR
      // ==========================================
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dashboard_customize,
                    color: AppPalette.primary,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Cross-App Board',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded),
                  onPressed: () {},
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppPalette.primaryLight,
                    child: Text(
                      'VK',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

      // ==========================================
      // DRAWER FOR MOBILE NAVIGATION
      // ==========================================
      drawer: isDesktop
          ? null
          : Drawer(
              child: SidebarNavigation(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (index) {
                  setState(() => _selectedNavIndex = index);
                },
                navItems: DashboardMockData.navItems,
                isDrawer: true,
              ),
            ),

      // ==========================================
      // ADAPTIVE BODY (Flexible / Expanded Proportions)
      // ==========================================
      body: SafeArea(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Persistent Left Navigation Sidebar (Flex 2)
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: SidebarNavigation(
                      selectedIndex: _selectedNavIndex,
                      onItemSelected: (index) {
                        setState(() => _selectedNavIndex = index);
                      },
                      navItems: DashboardMockData.navItems,
                      isDrawer: false,
                    ),
                  ),

                  // 2. Central Scrollable Dashboard (Flex 7)
                  Expanded(
                    flex: 7,
                    child: _buildDashboardScroll(
                      isMobile: false,
                      isTablet: false,
                      showActivities: false,
                    ),
                  ),

                  // 3. Persistent Right Activity Panel (Flex 3)
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: RightSidePanel(
                      activities: DashboardMockData.activities,
                    ),
                  ),
                ],
              )
            : isTablet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tablet Compact Rail Navigation
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: SidebarNavigation(
                          selectedIndex: _selectedNavIndex,
                          onItemSelected: (index) {
                            setState(() => _selectedNavIndex = index);
                          },
                          navItems: DashboardMockData.navItems,
                          isDrawer: false,
                          isCompactRail: true,
                        ),
                      ),

                      // Tablet Central Dashboard (With Activities)
                      Expanded(
                        flex: 7,
                        child: _buildDashboardScroll(
                          isMobile: false,
                          isTablet: true,
                          showActivities: true,
                        ),
                      ),
                    ],
                  )
                : _buildDashboardScroll(
                    isMobile: isMobile,
                    isTablet: false,
                    showActivities: true,
                  ),
      ),
    );
  }

  // ======================================================
  // DASHBOARD MAIN SCROLLABLE BODY (4 Clean Sections)
  // ======================================================
  Widget _buildDashboardScroll({
    required bool isMobile,
    required bool isTablet,
    required bool showActivities,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------------
          // SEARCH BAR & ACTIONS
          // --------------------------------------------------------
          HeaderSearchBar(
            searchController: _searchController,
            isMobile: isMobile,
          ),
          const SizedBox(height: 24),

          // --------------------------------------------------------
          // SECTION 1: SYSTEM OVERVIEW (KPI Metrics GridView)
          // --------------------------------------------------------
          const SectionHeading(
            title: 'System Overview',
            subtitle: 'Real-time telemetry and resource performance indicators',
            badgeText: 'Live Stream',
          ),
          const SizedBox(height: 14),
          KpiMetricsGrid(
            metrics: DashboardMockData.metrics,
            isMobile: isMobile,
            isTablet: isTablet,
          ),
          const SizedBox(height: 28),

          // --------------------------------------------------------
          // SECTION 2: CATEGORY FILTER (Horizontal ListView)
          // --------------------------------------------------------
          SectionHeading(
            title: _selectedNavIndex == 1
                ? 'Bookmarked Repositories'
                : 'Active Repositories & Modules',
            subtitle: _selectedNavIndex == 1
                ? 'Your pinned repositories and tasks'
                : 'Filtered project tracks and deliverables',
            trailingWidget: Text(
              '${_filteredProjects.length} Items',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppPalette.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          CategoryFilterBar(
            categories: DashboardMockData.categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
            },
          ),
          const SizedBox(height: 16),

          // --------------------------------------------------------
          // SECTION 3: PROJECTS CATALOG (Responsive GridView)
          // --------------------------------------------------------
          ProjectCatalogGrid(
            projects: _filteredProjects,
            bookmarkedProjectIds: _bookmarkedProjectIds,
            onToggleBookmark: _toggleBookmark,
            onProjectSelected: _openProjectDetails,
            isMobile: isMobile,
            isTablet: isTablet,
          ),

          // --------------------------------------------------------
          // SECTION 4: ACTIVITY STREAM (Mobile & Tablet ListView)
          // --------------------------------------------------------
          if (showActivities) ...[
            const SizedBox(height: 32),
            const SectionHeading(
              title: 'Activity Stream',
              subtitle: 'Recent commits, reviews and pipeline alerts',
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppPalette.cardBorder),
              ),
              child: ActivityStreamList(
                activities: DashboardMockData.activities,
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
