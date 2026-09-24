import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/product.dart';

/// FilterModalSheet presents an interactive bottom sheet for sorting and filtering.
class FilterModalSheet extends StatefulWidget {
  final ProductSortOption currentSort;
  final bool currentInStockOnly;
  final ValueChanged<ProductSortOption> onSortChanged;
  final ValueChanged<bool> onInStockChanged;
  final VoidCallback onReset;

  const FilterModalSheet({
    super.key,
    required this.currentSort,
    required this.currentInStockOnly,
    required this.onSortChanged,
    required this.onInStockChanged,
    required this.onReset,
  });

  @override
  State<FilterModalSheet> createState() => _FilterModalSheetState();
}

class _FilterModalSheetState extends State<FilterModalSheet> {
  late ProductSortOption _selectedSort;
  late bool _inStockOnly;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
    _inStockOnly = widget.currentInStockOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppPalette.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sheet Title & Reset Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sort & Filter',
                  style: TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSort = ProductSortOption.featured;
                      _inStockOnly = false;
                    });
                    widget.onReset();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Reset All',
                    style: TextStyle(
                      color: AppPalette.danger,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: AppPalette.divider),
            const SizedBox(height: 12),

            // ==========================================
            // SORT OPTIONS
            // ==========================================
            const Text(
              'Sort By',
              style: TextStyle(
                color: AppPalette.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ProductSortOption.values.map((sortOption) {
                final isSelected = _selectedSort == sortOption;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        sortOption.icon,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : AppPalette.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(sortOption.label),
                    ],
                  ),
                  selected: isSelected,
                  selectedColor: AppPalette.primary,
                  backgroundColor: AppPalette.surfaceVariant,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : AppPalette.textPrimary,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isSelected
                          ? AppPalette.primary
                          : AppPalette.cardBorder,
                    ),
                  ),
                  showCheckmark: false,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedSort = sortOption;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppPalette.divider),

            // ==========================================
            // AVAILABILITY TOGGLE
            // ==========================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'In Stock Only',
                      style: TextStyle(
                        color: AppPalette.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Hide items currently out of stock',
                      style: TextStyle(
                        color: AppPalette.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Switch.adaptive(
                  value: _inStockOnly,
                  activeTrackColor: AppPalette.primary,
                  onChanged: (val) {
                    setState(() {
                      _inStockOnly = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ==========================================
            // APPLY BUTTON
            // ==========================================
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSortChanged(_selectedSort);
                  widget.onInStockChanged(_inStockOnly);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply Changes',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
