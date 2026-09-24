import 'package:flutter/material.dart';
import '../constants/app_palette.dart';
import '../models/todo_task.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/todo_item_tile.dart';
import '../widgets/todo_stats_card.dart';

/// Main Todo Screen managed as a StatefulWidget.
///
/// Demonstrates explicit state transitions via `setState`:
/// - Add new task (`_addTask`)
/// - Mark-complete / uncomplete (`_toggleTask`)
/// - Delete task with undo capability (`_deleteTask`)
/// - Clear completed batch operation (`_clearCompletedTasks`)
/// - Real-time filtering and search
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // Primary state list holding all tasks
  late List<TodoTask> _tasks;

  // Active filter state
  TodoFilter _selectedFilter = TodoFilter.all;

  // Search input state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Initialize with sample tasks showcasing various categories and statuses
    _tasks = TodoTask.getSampleTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ======================================================
  // STATE MUTATION METHODS (Using setState)
  // ======================================================

  /// Adds a new task to the top of the list and updates the UI.
  void _addTask(TodoTask task) {
    setState(() {
      _tasks.insert(0, task);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${task.title}"'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: AppPalette.textPrimary,
      ),
    );
  }

  /// Toggles the completed status of the specified task.
  void _toggleTask(String id) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        _tasks[index].toggleCompleted();
      }
    });
  }

  /// Deletes a task by id with an immediate SnackBar Undo option.
  void _deleteTask(String id) {
    final taskIndex = _tasks.indexWhere((t) => t.id == id);
    if (taskIndex == -1) return;

    final removedTask = _tasks[taskIndex];

    setState(() {
      _tasks.removeAt(taskIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${removedTask.title}"'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppPalette.warning,
          onPressed: () {
            setState(() {
              _tasks.insert(taskIndex, removedTask);
            });
          },
        ),
      ),
    );
  }

  /// Bulk delete for all completed tasks with confirmation dialog.
  void _confirmClearCompleted() {
    final completedCount = _tasks.where((t) => t.isCompleted).length;
    if (completedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No completed tasks to clear.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Completed Tasks?'),
        content: Text(
          'This will permanently delete $completedCount completed tasks.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _tasks.removeWhere((t) => t.isCompleted);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cleared $completedCount completed tasks.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  /// Opens the bottom sheet modal for adding a new task.
  void _openAddTaskModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTaskSheet(onTaskCreated: _addTask),
    );
  }

  // ======================================================
  // COMPUTED GETTERS & FILTERS
  // ======================================================

  int get _totalCount => _tasks.length;
  int get _completedCount => _tasks.where((t) => t.isCompleted).length;
  int get _pendingCount => _tasks.where((t) => !t.isCompleted).length;

  List<TodoTask> get _filteredTasks {
    return _tasks.where((task) {
      // 1. Status Filter
      final matchesFilter = switch (_selectedFilter) {
        TodoFilter.all => true,
        TodoFilter.active => !task.isCompleted,
        TodoFilter.completed => task.isCompleted,
      };

      // 2. Search Query Filter
      final matchesSearch = _searchQuery.isEmpty ||
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (task.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  // ======================================================
  // BUILD METHOD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTasks;

    return Scaffold(
      backgroundColor: AppPalette.background,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.check_circle_outline_rounded, color: AppPalette.primary),
            SizedBox(width: 8),
            Text(
              'My Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppPalette.textPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: AppPalette.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear completed tasks',
            color: AppPalette.textSecondary,
            onPressed: _confirmClearCompleted,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Header Stats & Progress Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: TodoStatsCard(
                totalCount: _totalCount,
                completedCount: _completedCount,
                pendingCount: _pendingCount,
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppPalette.textMuted,
                    size: 20,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppPalette.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppPalette.cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppPalette.cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppPalette.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
              ),
            ),
          ),

          // Filter Segment Bar (All, Pending, Completed)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: CategoryFilterBar(
                selectedFilter: _selectedFilter,
                allCount: _totalCount,
                activeCount: _pendingCount,
                completedCount: _completedCount,
                onFilterSelected: (newFilter) {
                  setState(() {
                    _selectedFilter = newFilter;
                  });
                },
              ),
            ),
          ),

          // Task List or Empty State
          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyStateWidget(
                filter: _selectedFilter,
                searchQuery: _searchQuery,
                onAddTask: _openAddTaskModal,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 90),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = filtered[index];
                    return TodoItemTile(
                      key: ValueKey(task.id),
                      task: task,
                      onToggle: () => _toggleTask(task.id),
                      onDelete: () => _deleteTask(task.id),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTaskModal,
        backgroundColor: AppPalette.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Fallback illustration shown when no tasks match current search/filters.
class _EmptyStateWidget extends StatelessWidget {
  final TodoFilter filter;
  final String searchQuery;
  final VoidCallback onAddTask;

  const _EmptyStateWidget({
    required this.filter,
    required this.searchQuery,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppPalette.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching
                    ? Icons.search_off_rounded
                    : switch (filter) {
                        TodoFilter.all => Icons.task_alt_rounded,
                        TodoFilter.active => Icons.done_all_rounded,
                        TodoFilter.completed => Icons.hourglass_empty_rounded,
                      },
                size: 40,
                color: AppPalette.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isSearching
                  ? 'No tasks found'
                  : switch (filter) {
                      TodoFilter.all => 'No tasks yet',
                      TodoFilter.active => 'No pending tasks',
                      TodoFilter.completed => 'No completed tasks',
                    },
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppPalette.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isSearching
                  ? 'No task matches "$searchQuery". Try a different search.'
                  : switch (filter) {
                      TodoFilter.all => 'Tap "Add Task" below to start organizing your day.',
                      TodoFilter.active => 'All caught up! Great job staying on top of things.',
                      TodoFilter.completed => 'Mark tasks complete to see them tracked here.',
                    },
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppPalette.textSecondary,
                height: 1.4,
              ),
            ),
            if (!isSearching && filter == TodoFilter.all) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onAddTask,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add First Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
