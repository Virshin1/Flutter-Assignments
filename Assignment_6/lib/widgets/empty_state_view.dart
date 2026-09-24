import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

/// EmptyStateView shown when no products match the search or filter query.
class EmptyStateView extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onReset;

  const EmptyStateView({
    super.key,
    required this.searchQuery,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ambient icon circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppPalette.primaryLight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppPalette.primary.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.search_off_rounded,
                  size: 40,
                  color: AppPalette.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'No Products Found',
              style: TextStyle(
                color: AppPalette.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              searchQuery.isNotEmpty
                  ? 'We couldn\'t find any items matching "$searchQuery". Try checking for typos or resetting your filters.'
                  : 'No products match the selected category and filter criteria.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppPalette.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Reset Filters Action Button
            ElevatedButton.icon(
              onPressed: onReset,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Reset All Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
