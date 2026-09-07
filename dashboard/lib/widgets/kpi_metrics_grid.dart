import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/metric_card_data.dart';

// ======================================================
// KPI METRICS (GridView with Dynamic Responsive Breakpoints)
// ======================================================
class KpiMetricsGrid extends StatelessWidget {
  final List<MetricCardData> metrics;
  final bool isMobile;
  final bool isTablet;
  final VoidCallback? onMetricTap;

  const KpiMetricsGrid({
    super.key,
    required this.metrics,
    required this.isMobile,
    required this.isTablet,
    this.onMetricTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic columns: 2 on Mobile & Tablet, 4 on Desktop
    final int crossAxisCount = isMobile ? 2 : (isTablet ? 2 : 4);
    final double childAspectRatio = isMobile ? 1.35 : (isTablet ? 1.25 : 1.12);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];

        return Material(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onMetricTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppPalette.cardBorder, width: 1.2),
                boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row: Icon badge + Trend Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: metric.lightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      metric.icon,
                      size: 20,
                      color: metric.accentColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: metric.isPositive
                          ? AppPalette.successLight
                          : AppPalette.dangerLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          metric.isPositive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          size: 11,
                          color: metric.isPositive
                              ? AppPalette.success
                              : AppPalette.danger,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          metric.change,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: metric.isPositive
                                ? AppPalette.success
                                : AppPalette.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Bottom Section: Big Value and Metric Label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metric.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    metric.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppPalette.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }
}
