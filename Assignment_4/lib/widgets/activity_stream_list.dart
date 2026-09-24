import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/activity_item_data.dart';

// ======================================================
// ACTIVITY STREAM (Vertical ListView Builder)
// ======================================================
class ActivityStreamList extends StatelessWidget {
  final List<ActivityItemData> activities;

  const ActivityStreamList({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const Divider(
        color: AppPalette.cardBorder,
        height: 16,
      ),
      itemBuilder: (context, index) {
        final activity = activities[index];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: activity.avatarColor.withValues(alpha: 0.15),
              child: Icon(
                activity.statusIcon,
                size: 16,
                color: activity.avatarColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    activity.description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppPalette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              activity.timestamp,
              style: const TextStyle(
                fontSize: 10.5,
                color: AppPalette.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
