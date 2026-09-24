import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/product.dart';

/// CategorySelector displays a horizontally scrollable list of category filter pills.
class CategorySelector extends StatelessWidget {
  final ProductCategory selectedCategory;
  final ValueChanged<ProductCategory> onCategorySelected;
  final Map<ProductCategory, int> categoryCounts;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categoryCounts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: ProductCategory.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = ProductCategory.values[index];
          final isSelected = category == selectedCategory;
          final count = categoryCounts[category] ?? 0;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onCategorySelected(category),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppPalette.primary : AppPalette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppPalette.primary
                        : AppPalette.cardBorder,
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? AppPalette.floatingShadow
                      : AppPalette.cardShadow,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      size: 16,
                      color: isSelected ? Colors.white : AppPalette.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.label,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : AppPalette.textPrimary,
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Item Count Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.25)
                            : AppPalette.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppPalette.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
