import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/todo_task.dart';

/// Horizontal filter selector bar for toggling between All, Pending, and Completed tasks.
class CategoryFilterBar extends StatelessWidget {
  final TodoFilter selectedFilter;
  final int allCount;
  final int activeCount;
  final int completedCount;
  final ValueChanged<TodoFilter> onFilterSelected;

  const CategoryFilterBar({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.activeCount,
    required this.completedCount,
    required this.onFilterSelected,
  });

  int _countFor(TodoFilter filter) => switch (filter) {
        TodoFilter.all => allCount,
        TodoFilter.active => activeCount,
        TodoFilter.completed => completedCount,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPalette.cardBorder.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: TodoFilter.values.map((filter) {
          final isSelected = selectedFilter == filter;
          final count = _countFor(filter);

          return Expanded(
            child: GestureDetector(
              onTap: () => onFilterSelected(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppPalette.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected ? AppPalette.cardShadow : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      filter.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? AppPalette.primary
                            : AppPalette.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppPalette.primaryLight
                            : AppPalette.cardBorder,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppPalette.primary
                              : AppPalette.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
