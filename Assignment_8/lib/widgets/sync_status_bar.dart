import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/api_service.dart';

class SyncStatusBar extends StatelessWidget {
  final FeedResult result;
  final VoidCallback onRefresh;
  final VoidCallback onClearCache;

  const SyncStatusBar({
    super.key,
    required this.result,
    required this.onRefresh,
    required this.onClearCache,
  });

  @override
  Widget build(BuildContext context) {
    final isLive = result.isLive;
    final primaryColor = isLive ? AppColors.online : AppColors.cached;
    final bgColor = isLive ? AppColors.onlineLight : AppColors.cachedLight;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLive ? Icons.wifi_rounded : Icons.offline_bolt_rounded,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      isLive ? 'LIVE REST API' : 'OFFLINE CACHE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '• ${result.posts.length} items',
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isLive
                      ? 'Synced with JSONPlaceholder at ${result.formattedSyncTime}'
                      : 'Loaded from SharedPreferences • ${result.formattedSyncTime}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Clear Cache',
            icon: const Icon(Icons.delete_sweep_outlined, size: 20),
            color: AppColors.textSecondary,
            onPressed: onClearCache,
          ),
          IconButton(
            tooltip: 'Fetch Live',
            icon: const Icon(Icons.refresh_rounded, size: 20),
            color: AppColors.primary,
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}
