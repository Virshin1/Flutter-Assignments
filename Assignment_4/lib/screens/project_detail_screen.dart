import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/dashboard_models.dart';

// ======================================================
// PROJECT DETAIL SCREEN (Simple & Clean Subpage)
// ======================================================
class ProjectDetailScreen extends StatefulWidget {
  final ProjectCardData project;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;

  const ProjectDetailScreen({
    super.key,
    required this.project,
    required this.isBookmarked,
    required this.onToggleBookmark,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  void _handleBookmarkToggle() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    widget.onToggleBookmark();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppPalette.background,

      // ==========================================
      // APP BAR (With Back Navigation)
      // ==========================================
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.project.id,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? AppPalette.accent : AppPalette.textSecondary,
            ),
            onPressed: _handleBookmarkToggle,
          ),
        ],
      ),

      // ==========================================
      // BODY (Single Scrollable Container)
      // ==========================================
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------------------------------------
                // 1. PROJECT HEADER CARD
                // --------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppPalette.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppPalette.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppPalette.primaryLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              widget.project.icon,
                              color: AppPalette.primary,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppPalette.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppPalette.primaryLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    widget.project.category,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppPalette.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Project Overview',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'This project is managed within the Cross-App workspace. It features multi-screen adaptive layouts, real-time metrics tracking, and modular component architecture.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppPalette.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // --------------------------------------------------------
                // 2. PROGRESS & METRICS CARD
                // --------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppPalette.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppPalette.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sprint Progress',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.textPrimary,
                            ),
                          ),
                          Text(
                            widget.project.progressPercentage,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: widget.project.progress,
                          minHeight: 8,
                          backgroundColor: AppPalette.cardBorder,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppPalette.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: AppPalette.cardBorder, height: 1),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDetailStat(
                            icon: Icons.calendar_today_outlined,
                            label: 'Due Date',
                            value: widget.project.dueDate,
                          ),
                          _buildDetailStat(
                            icon: Icons.people_outline,
                            label: 'Contributors',
                            value: '${widget.project.teamMembers} Members',
                          ),
                          _buildDetailStat(
                            icon: Icons.check_circle_outline,
                            label: 'Status',
                            value: 'Active',
                            valueColor: AppPalette.success,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // --------------------------------------------------------
                // 3. ACTION BUTTONS
                // --------------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppPalette.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _handleBookmarkToggle,
                        icon: Icon(
                          _isBookmarked
                              ? Icons.bookmark_remove_outlined
                              : Icons.bookmark_add_outlined,
                          color: AppPalette.primary,
                          size: 18,
                        ),
                        label: Text(
                          _isBookmarked ? 'Bookmarked' : 'Bookmark',
                          style: const TextStyle(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Project changes saved!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text(
                          'Done & Return',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailStat({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppPalette.textSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppPalette.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppPalette.textMuted,
          ),
        ),
      ],
    );
  }
}
