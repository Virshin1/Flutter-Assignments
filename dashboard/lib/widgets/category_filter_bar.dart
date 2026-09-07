import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

// ======================================================
// CATEGORY FILTER BAR (Horizontal ListView Selector)
// ======================================================
class CategoryFilterBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = selectedCategory == category;

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onCategorySelected(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppPalette.primary : AppPalette.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppPalette.primary : AppPalette.cardBorder,
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? const [
                        BoxShadow(
                          color: Color(0x334F46E5),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : AppPalette.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
