import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

// ======================================================
// STORAGE QUOTA CARD (BoxDecoration & Progress Bar)
// ======================================================
class StorageQuotaCard extends StatelessWidget {
  const StorageQuotaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPalette.primaryLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppPalette.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.cloud_done_rounded,
                color: AppPalette.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Cloud Storage Quota',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '82.4 GB of 100 GB used across 24 project build artifacts',
            style: TextStyle(fontSize: 11.5, color: AppPalette.textSecondary),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const LinearProgressIndicator(
              value: 0.824,
              backgroundColor: Colors.white,
              color: AppPalette.primary,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Storage upgrade request submitted.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'Upgrade Workspace Storage',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
