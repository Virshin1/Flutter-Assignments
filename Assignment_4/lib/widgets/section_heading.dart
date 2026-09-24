import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

// ======================================================
// SECTION HEADING WIDGET (With Subtitle & Status Badge)
// ======================================================
class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? badgeText;
  final Widget? trailingWidget;

  const SectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
    this.badgeText,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  if (badgeText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.successLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppPalette.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              badgeText!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppPalette.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppPalette.textSecondary,
                ),
              ),
            ],
          ),
        ),
        ?trailingWidget,
      ],
    );
  }
}
