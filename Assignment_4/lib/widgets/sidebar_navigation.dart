import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/nav_item_data.dart';

// ======================================================
// SIDEBAR & DRAWER NAVIGATION (Responsive Navigation Rail)
// ======================================================
class SidebarNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavItemData> navItems;
  final bool isDrawer;
  final bool isCompactRail;

  const SidebarNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.navItems,
    this.isDrawer = false,
    this.isCompactRail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.sidebarBg,
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // --------------------------------------------------------
          // 1. BRANDING HEADER (Icon + Workspace Titles)
          // --------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                if (!isCompactRail) ...[
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cross-App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        Text(
                          'Control Center',
                          style: TextStyle(
                            color: AppPalette.textMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 12),

          // --------------------------------------------------------
          // 2. NAV TILES LIST (ListView with dynamic selection)
          // --------------------------------------------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final bool isActive = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      onItemSelected(index);
                      if (isDrawer) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isCompactRail ? 10 : 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppPalette.sidebarActive
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isActive
                              ? AppPalette.primary.withValues(alpha: 0.5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: isCompactRail
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: isActive
                                ? Colors.white
                                : AppPalette.textMuted,
                          ),
                          if (!isCompactRail) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : AppPalette.textMuted,
                                  fontSize: 14,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (item.badgeText != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppPalette.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item.badgeText!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // --------------------------------------------------------
          // 3. USER PROFILE FOOTER (CircleAvatar + User Metadata)
          // --------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: AppPalette.primary,
                  child: Text(
                    'VK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!isCompactRail) ...[
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Virshin Kumar',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lead Mobile Architect',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppPalette.textMuted,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
