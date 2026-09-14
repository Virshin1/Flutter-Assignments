import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

/// SearchFilterHeader provides a modern search input field and a filter trigger button.
///
/// Triggers callbacks for real-time search queries and filter modal opening.
class SearchFilterHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onFilterTap;
  final bool hasActiveFilters;

  const SearchFilterHeader({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.onFilterTap,
    this.hasActiveFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppPalette.cardBorder, width: 1.2),
                boxShadow: AppPalette.cardShadow,
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: const TextStyle(
                  color: AppPalette.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Search products, brands, tags...',
                  hintStyle: const TextStyle(
                    color: AppPalette.textMuted,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppPalette.textMuted,
                    size: 20,
                  ),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppPalette.textMuted,
                            size: 18,
                          ),
                          onPressed: onClear,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Filter Button with Active Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: hasActiveFilters
                      ? AppPalette.primaryLight
                      : AppPalette.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: hasActiveFilters
                        ? AppPalette.primary
                        : AppPalette.cardBorder,
                    width: 1.2,
                  ),
                  boxShadow: AppPalette.cardShadow,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.tune_rounded,
                    color: hasActiveFilters
                        ? AppPalette.primary
                        : AppPalette.textSecondary,
                    size: 20,
                  ),
                  onPressed: onFilterTap,
                  tooltip: 'Sort and filter options',
                ),
              ),
              if (hasActiveFilters)
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppPalette.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppPalette.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
