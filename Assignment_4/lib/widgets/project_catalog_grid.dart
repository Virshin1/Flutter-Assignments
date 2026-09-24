import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/project_card_data.dart';

// ======================================================
// PROJECT CATALOG GRID (GridView with Dynamic Breakpoints)
// ======================================================
class ProjectCatalogGrid extends StatelessWidget {
  final List<ProjectCardData> projects;
  final Set<String> bookmarkedProjectIds;
  final ValueChanged<String> onToggleBookmark;
  final ValueChanged<ProjectCardData>? onProjectSelected;
  final bool isMobile;
  final bool isTablet;

  const ProjectCatalogGrid({
    super.key,
    required this.projects,
    required this.bookmarkedProjectIds,
    required this.onToggleBookmark,
    this.onProjectSelected,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic columns: 1 on Mobile, 2 on Tablet, 3 on Desktop
    final int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
    final double childAspectRatio = isMobile ? 1.55 : (isTablet ? 1.18 : 1.02);

    if (projects.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppPalette.cardBorder),
        ),
        child: const Column(
          children: [
            Icon(Icons.folder_off_outlined,
                size: 48, color: AppPalette.textMuted),
            SizedBox(height: 12),
            Text(
              'No repositories match the active category filter',
              style: TextStyle(
                color: AppPalette.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        final bool isBookmarked = bookmarkedProjectIds.contains(project.id);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onProjectSelected?.call(project),
            child: Container(
              padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppPalette.cardBorder, width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Bar: Category Pill & Bookmark Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        project.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked
                          ? AppPalette.accent
                          : AppPalette.textMuted,
                    ),
                    onPressed: () => onToggleBookmark(project.id),
                  ),
                ],
              ),

              // Title and Icon Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppPalette.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppPalette.cardBorder),
                    ),
                    child: Icon(
                      project.icon,
                      size: 20,
                      color: AppPalette.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.textPrimary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),

              // Progress Bar with Percentage
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Completion',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: AppPalette.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        project.progressPercentage,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: project.progress,
                      backgroundColor: AppPalette.background,
                      color: project.progress > 0.8
                          ? AppPalette.success
                          : AppPalette.primary,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),

              // Card Footer: Team members count & Due date
              Container(
                padding: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppPalette.cardBorder)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: AppPalette.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              project.dueDate,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppPalette.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.background,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppPalette.cardBorder),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.groups_outlined,
                            size: 13,
                            color: AppPalette.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${project.teamMembers}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
