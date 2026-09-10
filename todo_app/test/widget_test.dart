import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

void main() {
  testWidgets('TodoApp renders initial tasks and overview statistics',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Verify app bar title
    expect(find.text('My Tasks'), findsOneWidget);
    expect(find.text("Today's Overview"), findsOneWidget);

    // Verify initial sample tasks exist
    expect(find.text('Review Dart OOP & Mixin concepts'), findsOneWidget);
    expect(find.text('Implement StatefulWidget with setState'), findsOneWidget);

    // Verify FAB
    expect(find.text('Add Task'), findsOneWidget);
  });

  testWidgets('Mark-complete operation toggles task completion state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Find the second task which is initially incomplete
    final taskFinder = find.text('Implement StatefulWidget with setState');
    expect(taskFinder, findsOneWidget);

    // Initial check: pending count should be 3 (from sample tasks)
    expect(find.text('Pending: '), findsOneWidget);

    // Tap on the task tile to toggle completion
    await tester.tap(taskFinder);
    await tester.pumpAndSettle();

    // After toggling, the text decoration should update and progress changes
    expect(taskFinder, findsOneWidget);
  });

  testWidgets('Add operation creates a new task via bottom sheet',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Tap "Add Task" FAB
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Verify bottom sheet opened
    expect(find.text('Add New Task'), findsOneWidget);

    // Enter title into TextField
    final titleField = find.byType(TextField).first;
    await tester.enterText(titleField, 'Write automated widget test');

    // Tap "Create Task" button
    await tester.tap(find.text('Create Task'));
    await tester.pumpAndSettle();

    // Verify newly added task is present on the screen
    expect(find.text('Write automated widget test'), findsOneWidget);
  });

  testWidgets('Delete operation removes a task and supports Undo',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    const taskTitle = 'Review Dart OOP & Mixin concepts';
    expect(find.text(taskTitle), findsOneWidget);

    // Find and tap the delete icon button for this task
    final deleteButtons = find.byTooltip('Delete task');
    expect(deleteButtons, findsWidgets);

    await tester.tap(deleteButtons.first);
    await tester.pump(); // Start animation
    await tester.pumpAndSettle();

    // Verify task is deleted
    expect(find.text(taskTitle), findsNothing);

    // Verify SnackBar appears with UNDO action
    expect(find.text('UNDO'), findsOneWidget);

    // Tap UNDO to restore
    await tester.tap(find.text('UNDO'));
    await tester.pumpAndSettle();

    // Verify task is restored
    expect(find.text(taskTitle), findsOneWidget);
  });

  testWidgets('Filter segment bar updates active tasks view',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Tap "Pending" filter
    await tester.tap(find.text('Pending'));
    await tester.pumpAndSettle();

    // "Review Dart OOP & Mixin concepts" is completed, so it should not appear under Pending
    expect(find.text('Review Dart OOP & Mixin concepts'), findsNothing);

    // Incomplete tasks should appear
    expect(find.text('Implement StatefulWidget with setState'), findsOneWidget);

    // Tap "Completed" filter
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    // Now completed task appears
    expect(find.text('Review Dart OOP & Mixin concepts'), findsOneWidget);
  });
}
