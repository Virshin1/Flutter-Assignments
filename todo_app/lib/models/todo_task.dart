import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

/// Task priority enumeration with associated display labels and color tokens.
enum TaskPriority {
  low,
  medium,
  high;

  String get label => switch (this) {
        TaskPriority.low => 'Low',
        TaskPriority.medium => 'Medium',
        TaskPriority.high => 'High',
      };

  Color get color => switch (this) {
        TaskPriority.low => AppPalette.priorityLow,
        TaskPriority.medium => AppPalette.priorityMedium,
        TaskPriority.high => AppPalette.priorityHigh,
      };

  Color get backgroundColor => switch (this) {
        TaskPriority.low => AppPalette.priorityLowBg,
        TaskPriority.medium => AppPalette.priorityMediumBg,
        TaskPriority.high => AppPalette.priorityHighBg,
      };
}

/// Task category categorization with associated icons and labels.
enum TaskCategory {
  study,
  work,
  personal,
  health;

  String get label => switch (this) {
        TaskCategory.study => 'Study',
        TaskCategory.work => 'Work',
        TaskCategory.personal => 'Personal',
        TaskCategory.health => 'Health',
      };

  IconData get icon => switch (this) {
        TaskCategory.study => Icons.school_outlined,
        TaskCategory.work => Icons.work_outline,
        TaskCategory.personal => Icons.person_outline,
        TaskCategory.health => Icons.favorite_border,
      };

  Color get color => switch (this) {
        TaskCategory.study => AppPalette.catStudy,
        TaskCategory.work => AppPalette.catWork,
        TaskCategory.personal => AppPalette.catPersonal,
        TaskCategory.health => AppPalette.catHealth,
      };
}

/// Filter state enum for filtering between All, Active (pending), and Completed tasks.
enum TodoFilter {
  all,
  active,
  completed;

  String get label => switch (this) {
        TodoFilter.all => 'All',
        TodoFilter.active => 'Pending',
        TodoFilter.completed => 'Completed',
      };
}

/// Domain model representing a single Todo item.
/// Demonstrates OOP, null safety, named constructors, and immutability options
/// from the root Dart concepts (`task1_books.dart` - `task10_lib.dart`).
class TodoTask {
  final String id;
  String title;
  String? description;
  TaskCategory category;
  TaskPriority priority;
  bool isCompleted;
  final DateTime createdAt;

  TodoTask({
    required this.id,
    required this.title,
    this.description,
    this.category = TaskCategory.personal,
    this.priority = TaskPriority.medium,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Toggles the completion state of the task.
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  /// Creates a modified copy of this TodoTask.
  TodoTask copyWith({
    String? id,
    String? title,
    String? description,
    TaskCategory? category,
    TaskPriority? priority,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Initial sample tasks demonstrating diverse categories and states.
  static List<TodoTask> getSampleTasks() {
    final now = DateTime.now();
    return [
      TodoTask(
        id: '1',
        title: 'Review Dart OOP & Mixin concepts',
        description: 'Go through task1_books to task10_lib in the root repository.',
        category: TaskCategory.study,
        priority: TaskPriority.high,
        isCompleted: true,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      TodoTask(
        id: '2',
        title: 'Implement StatefulWidget with setState',
        description: 'Build intermediate Todo app supporting add, delete, and mark-complete.',
        category: TaskCategory.work,
        priority: TaskPriority.high,
        isCompleted: false,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      TodoTask(
        id: '3',
        title: 'Complete 30-minute evening walk',
        description: 'Listen to Flutter podcast and log fitness activity.',
        category: TaskCategory.health,
        priority: TaskPriority.low,
        isCompleted: false,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      TodoTask(
        id: '4',
        title: 'Organize workspace project files',
        description: 'Clean up unused assets and structure assignment folders.',
        category: TaskCategory.personal,
        priority: TaskPriority.medium,
        isCompleted: false,
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),
    ];
  }
}
