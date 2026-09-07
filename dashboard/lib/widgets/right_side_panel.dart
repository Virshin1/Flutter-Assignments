import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/activity_item_data.dart';
import 'section_heading.dart';
import 'activity_stream_list.dart';
import 'storage_quota_card.dart';

// ======================================================
// RIGHT SIDE PANEL (Desktop Activity Stream & User Card)
// ======================================================
class RightSidePanel extends StatelessWidget {
  final List<ActivityItemData> activities;

  const RightSidePanel({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppPalette.surface,
        border: Border(
          left: BorderSide(
            color: AppPalette.cardBorder,
            width: 1,
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Lead User Mini-Profile Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppPalette.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppPalette.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppPalette.primary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppPalette.primaryLight,
                    child: Text(
                      'VK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R Virshin Kumar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'CS & AI • 150096724147',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section Heading
          const SectionHeading(
            title: 'Live Activity',
            subtitle: 'Recent pipeline notifications',
          ),
          const SizedBox(height: 12),

          // Activity Timeline List
          ActivityStreamList(activities: activities),

          const SizedBox(height: 24),

          // Workspace Storage & Quota Card
          const StorageQuotaCard(),
        ],
      ),
    );
  }
}
