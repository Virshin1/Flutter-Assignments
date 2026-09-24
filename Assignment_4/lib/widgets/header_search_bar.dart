import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

// ======================================================
// HEADER SEARCH BAR (Row + Flexible / Expanded + Input)
// ======================================================
class HeaderSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final bool isMobile;
  final VoidCallback? onExport;

  const HeaderSearchBar({
    super.key,
    required this.searchController,
    required this.isMobile,
    this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Title greeting on desktop & tablet
        if (!isMobile)
          const Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workspace Dashboard',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage cross-platform projects, builds, and metrics',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppPalette.textSecondary,
                  ),
                ),
              ],
            ),
          ),

        // Search Input Box (Flexible in Row)
        Expanded(
          flex: isMobile ? 1 : 2,
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppPalette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppPalette.cardBorder),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: AppPalette.textMuted,
                ),
                hintText: 'Search modules, repositories...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: AppPalette.textMuted,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Quick Export / Sync Action Button
        OutlinedButton.icon(
          onPressed: onExport ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Dashboard telemetry snapshot exported successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
          icon: const Icon(Icons.download_rounded, size: 18),
          label: isMobile ? const Text('Sync') : const Text('Export Report'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppPalette.textPrimary,
            side: const BorderSide(color: AppPalette.cardBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
