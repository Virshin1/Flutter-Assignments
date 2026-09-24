# 📱 FocusTrack: Intermediate Todo Application — Comprehensive Technical Documentation & Visual Audit

**Author**: R Virshin Kumar  
**Registration Number**: 150096724147  
**Workspace**: `Cross-App / Assignments / todo_app`  
**Git Branch**: `assignment_5`  
**Framework**: Flutter SDK (Channel Stable 3.47.0, Dart 3.13.0)  
**Architecture**: Layered Component Architecture with `StatefulWidget` & `setState`  

---

## 1. Executive Summary & Project Objectives

The **FocusTrack Todo Application** is an intermediate-level, production-grade productivity client built entirely with core Flutter SDK widgets and Dart standard language features. Developed as part of Assignment 5 in the `Cross-App` workspace, this project emphasizes mastering explicit, reactive state management using `StatefulWidget` and `setState()` without relying on third-party state orchestration packages.

The application addresses four fundamental software engineering objectives:
1. **Uncompromising Operational Correctness**: Flawless implementation of the primary CRUD and state alteration operations — **Add Task**, **Mark Complete**, and **Delete Task** (augmented by non-destructive **Undo** restoration and bulk purge).
2. **Pedagogical Alignment with Repository Foundations**: Direct application of object-oriented programming (OOP), generic collections (`List<T>`), pattern matching, and sound null safety introduced across `lib/task1_books.dart` through `task10_lib.dart` and `dart_basics-main/`.
3. **High-Performance Flutter Rendering**: Strict separation of concerns between stateful coordination and pure functional display widgets, guaranteeing minimal element rebuild trees and zero layout overflow exceptions.
4. **Curated Aesthetic Standard**: Implementation of an enterprise design token system (`AppPalette`) featuring harmonious slate, indigo, emerald, amber, and coral palettes, responsive typography, and tactile micro-interactions.

---

## 2. Theoretical Foundation: Flutter State Architecture

### 2.1 The Flutter Three-Tree Architecture

To understand how `StatefulWidget` operates at an intermediate level, one must examine Flutter's underlying runtime model comprising three parallel trees:
- **Widget Tree**: Lightweight, immutable configuration blueprints created and discarded frequently.
- **Element Tree**: Persistent lifecycle managers that bind the immutable widgets to their underlying rendered representations.
- **RenderObject Tree**: Heavy, mutable objects that handle layout sizing, hit testing, painting, and compositing to the screen canvas.

In FocusTrack, when `TodoApp` instantiates `TodoScreen`, Flutter assigns a persistent `StatefulElement` that hosts the `_TodoScreenState` instance. While widget configurations are rebuilt repeatedly, the state instance survives rebuild cycles, preserving the live in-memory task database `_tasks`.

### 2.2 Deep Dive into `setState()` Execution Lifecycle

The `setState(VoidCallback fn)` method is the cornerstone of Flutter's reactive model. Rather than performing immediate canvas redraws, calling `setState()` performs a precisely staged sequence:
1. **Synchronous Mutation Execution**: The callback closure passed to `setState` is executed immediately on the UI isolate, mutating the local state properties (such as `_tasks.insert(0, task)` or `task.toggleCompleted()`).
2. **Element Invalidation (`markNeedsBuild`)**: The `State` object marks its associated `StatefulElement` as "dirty" by pushing it to the framework's `BuildOwner` dirty elements list.
3. **Next Microtask Frame Scheduling**: Flutter's engine schedules a frame via the platform window VSYNC signal.
4. **Rebuild Traversal**: During the layout phase, the `BuildOwner` invokes `_TodoScreenState.build(context)`. Flutter diffs the old widget tree against the newly generated one using widget runtime types and keys (`ValueKey(task.id)`). Only elements whose configurations have changed update their corresponding `RenderObject`s.

```
[User Action: Tap Checkbox / Add / Delete]
                 │
                 ▼
         setState(() { ... })
                 │
                 ├─► 1. Synchronously mutate in-memory _tasks list
                 ├─► 2. Mark StatefulElement as 'dirty'
                 └─► 3. Request platform VSYNC frame from engine
                                   │
                                   ▼
                      BuildOwner invokes build()
                                   │
                                   ▼
                   Diffing via Element & ValueKey
                                   │
                                   ▼
              Targeted RenderObject repaint on Canvas
```

---

## 3. System Architecture & Component Decomposition

The project follows a clean, layered directory structure ensuring modularity, testability, and scalability:

```
todo_app/
├── pubspec.yaml                           # Flutter project configuration & SDK dependencies
├── README.md                              # Public overview, quickstart & concept matrix
├── DOCUMENTATION.md                       # Comprehensive architectural & technical report
├── screenshots/                           # High-resolution screenshots of all UI workflows
│   ├── 01_overview_screen.png
│   ├── 02_add_task_modal.png
│   ├── 03_task_completed.png
│   ├── 04_completed_filter.png
│   └── 05_delete_undo_snackbar.png
├── lib/
│   ├── main.dart                          # App entrypoint, Material 3 ThemeData & system UI setup
│   ├── constants/
│   │   └── app_palette.dart               # Theme design tokens, color constants & shadow utilities
│   ├── models/
│   │   └── todo_task.dart                 # TodoTask entity, TaskPriority, TaskCategory & TodoFilter enums
│   ├── widgets/
│   │   ├── todo_stats_card.dart           # Real-time progress metric card & KPI counters
│   │   ├── category_filter_bar.dart       # Segmented filter selector bar with badge counts
│   │   ├── todo_item_tile.dart            # Dismissible task card with animated checkbox & badges
│   │   └── add_task_sheet.dart            # Modal bottom sheet for task creation with validation
│   └── screens/
│       └── todo_screen.dart               # Primary orchestrator StatefulWidget managing all state
└── test/
    └── widget_test.dart                   # Automated test suite testing Add, Delete, Toggle & Filters
```

### 3.1 Layer Responsibilities

1. **Domain Model Layer (`models/todo_task.dart`)**:
   Encapsulates all business logic and data structures. It defines the core entity `TodoTask` and three strongly-typed enumerations (`TaskPriority`, `TaskCategory`, `TodoFilter`). It includes pure domain methods like `toggleCompleted()` and `copyWith()`, keeping business rules independent of the user interface.
2. **Design Tokens Layer (`constants/app_palette.dart`)**:
   Centralizes design tokens into immutable static constants. This eliminates hardcoded hex values, guarantees consistent spacing and contrast ratios, and facilitates rapid global theme adjustments.
3. **Component & Widget Layer (`widgets/`)**:
   Decomposes the visual tree into granular, reusable widgets:
   - `TodoStatsCard`: Pure display widget calculating completion ratios and displaying an animated `LinearProgressIndicator`.
   - `CategoryFilterBar`: Custom segmented control providing tactile selection with live count badges.
   - `TodoItemTile`: Interactive task item supporting swipe dismissal, custom checkmarks, strikethrough typography, and tags.
   - `AddTaskSheet`: Stateful form sheet with text editing controllers, validation errors, and choice chips.
4. **Presentation & Coordination Layer (`screens/todo_screen.dart`)**:
   Acts as the central coordinator. It owns the canonical task collection `_tasks`, processes user interactions, applies multi-criteria filter predicates, and triggers `setState()`.

---

## 4. In-Depth Operational Workflows

### 4.1 Add Task Operation

The addition workflow combines validation, modal presentation, and collection modification:
1. **User Initiation**: The user taps the `FloatingActionButton.extended` labeled "Add Task".
2. **Modal Sheet Invocation**: `_openAddTaskModal` displays `AddTaskSheet` using `showModalBottomSheet(isScrollControlled: true)`. The sheet is padded with `MediaQuery.of(context).viewInsets.bottom` to ensure text fields remain completely visible above the virtual keyboard.
3. **Form Validation**: When the user taps "Create Task", `_AddTaskSheetState._submit()` evaluates the trimmed title:
   - If empty, it sets `_errorMessage = 'Task title cannot be empty.'` and triggers a local `setState()` within the modal sheet to show a red error border.
   - If valid, it constructs a new `TodoTask` object with a unique timestamp ID (`DateTime.now().millisecondsSinceEpoch.toString()`), selected category, and chosen priority.
4. **State Injection**: The callback `widget.onTaskCreated(newTask)` sends the object back to `_TodoScreenState._addTask`, which executes:
   ```dart
   setState(() {
     _tasks.insert(0, task);
   });
   ```
   Inserting at index `0` ensures newly created tasks immediately appear at the top of the list.
5. **Feedback**: A floating `SnackBar` appears confirming `"Added \"<title>\""` while the modal sheet closes via `Navigator.pop(context)`.

### 4.2 Mark-Complete Operation

The completion workflow provides instant visual confirmation and metrics updates:
1. **User Initiation**: The user taps either the circular checkbox or anywhere across the task tile in `TodoItemTile`.
2. **State Mutation**: The callback triggers `_TodoScreenState._toggleTask(task.id)`:
   ```dart
   setState(() {
     final index = _tasks.indexWhere((t) => t.id == id);
     if (index != -1) {
       _tasks[index].toggleCompleted();
     }
   });
   ```
3. **Visual Transformation**:
   - The checkbox container animates from a neutral outline to an Emerald Green (`AppPalette.success`) circle displaying `Icons.check_rounded`.
   - The task title applies `TextDecoration.lineThrough` with a 2px thickness and transitions color from Slate-900 to muted slate.
   - The entire tile background fades to a semi-transparent surface tint (`AppPalette.surface.withValues(alpha: 0.75)`).
4. **Progress Recalculation**: In `TodoStatsCard`, `progressPercentage` recalculates dynamically via `(completedCount / totalCount).clamp(0.0, 1.0)`, animating the linear progress bar forward and updating the percentage badge.

### 4.3 Delete Task Operation with Non-Destructive Undo

The deletion workflow balances immediate responsiveness with defensive data safety:
1. **User Initiation**: The user can delete an item through two distinct gestures:
   - Tapping the trailing trash can `IconButton` on the tile.
   - Swiping the item from right to left using `Dismissible(direction: DismissDirection.endToStart)`.
2. **Temporary State Preservation**: Before removal, `_deleteTask(id)` locates the item and its index:
   ```dart
   final taskIndex = _tasks.indexWhere((t) => t.id == id);
   if (taskIndex == -1) return;
   final removedTask = _tasks[taskIndex];
   ```
3. **Atomic Removal**: `setState(() { _tasks.removeAt(taskIndex); });` immediately expels the item from the list and re-renders the viewport.
4. **Undo SnackBar Closure**: `ScaffoldMessenger` displays a floating `SnackBar` with a 4-second timeout:
   ```dart
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
   ```
   If the user taps **UNDO**, the closure restores `removedTask` precisely at `taskIndex`, ensuring ordinal list stability.

### 4.4 Real-Time Search & Multi-Filter Pipeline

The application features a computed getter `_filteredTasks` that executes a two-stage filter pipeline on every build:
```dart
List<TodoTask> get _filteredTasks {
  return _tasks.where((task) {
    // Stage 1: Status Filter via Dart 3 Switch Expression
    final matchesFilter = switch (_selectedFilter) {
      TodoFilter.all => true,
      TodoFilter.active => !task.isCompleted,
      TodoFilter.completed => task.isCompleted,
    };

    // Stage 2: Case-Insensitive String Matching on Title & Description
    final matchesSearch = _searchQuery.isEmpty ||
        task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        (task.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

    return matchesFilter && matchesSearch;
  }).toList();
}
```
When no tasks meet the combined filter criteria, `_EmptyStateWidget` renders a contextual empty state showing custom icons and instructions.

---

## 5. Mapping to Repository Concepts

The development of FocusTrack directly integrates core principles taught across the root folder of this workspace:

| Concept Category | Specific Root Workspace Source | Practical Implementation in `todo_app` |
| :--- | :--- | :--- |
| **Object-Oriented Modeling** | `lib/task1_books.dart`, `task2_constructor.dart`, `task10_lib.dart` | `TodoTask` class with encapsulated fields, named constructor with default parameters, and business methods (`toggleCompleted()`, `copyWith()`). |
| **Collections & List Operations** | `lib/task7_list.dart`, `dart_basics-main/2_collections.dart` | `List<TodoTask>` operations including `insert(0, ...)`, `removeAt()`, `indexWhere()`, `where()`, and `.length` counters. |
| **Dart 3 Switch Expressions** | `dart_basics-main/7_advanced_control_flow.dart` | Exhaustive pattern matching on `TaskPriority`, `TaskCategory`, and `TodoFilter` enums to derive display labels, background tints, and icons without switch boilerplate. |
| **Sound Null Safety** | `dart_basics-main/6_null_safety.dart`, `9_advanced_null_safety.dart` | Nullable `String? description`, safe Elvis operator `?.`, null coalescing fallbacks (`?? false`), and safe type casting. |
| **Design System & Tokens** | `dashboard/lib/constants/app_palette.dart` | Centralized `AppPalette` class defining colors, background layers, border radii, and drop shadows for visual consistency. |
| **Stateful Widget Lifecycle** | `first_ui/lib/main.dart`, `my_first_app/lib/main.dart` | Subclassing `StatefulWidget` and `State<T>`, managing lifecycle (`initState`, `dispose`), and invoking `setState` to trigger deterministic re-renders. |

---

## 6. Visual Audit & Screenshot Walkthrough

The following screenshots capture all core operational flows of the live application running on Flutter Web (viewport: 480x900 mobile):

### Screen 1: Primary Overview & Dashboard Metrics

![Figure 1: Initial Overview Screen](screenshots/01_overview_screen.png)

* **Visual Elements**:
  - Top `AppBar` with brand title and bulk purge action (`Icons.delete_sweep_outlined`).
  - Gradient `TodoStatsCard` displaying **Today's Overview**, dynamic completion percentage (`25%`), a linear progress bar, and 3 KPI badges (**Total: 4**, **Pending: 3**, **Completed: 1**).
  - Search input field with search icon and placeholder.
  - `CategoryFilterBar` segmented control highlighting **All** (`4`), **Pending** (`3`), and **Completed** (`1`).
  - `SliverList` showing diverse sample tasks across Study, Work, Health, and Personal categories.
  - Primary Floating Action Button: `+ Add Task`.

---

### Screen 2: Task Creation Modal Bottom Sheet

![Figure 2: Add Task Modal Sheet](screenshots/02_add_task_modal.png)

* **Visual Elements**:
  - Sliding modal bottom sheet with rounded top corners (24px radius) and visual drag handle.
  - Interactive `TextField` for Task Title with focus highlight (`AppPalette.primary`) and icon.
  - Multi-line `TextField` for optional contextual notes and descriptions.
  - Category selector chips with integrated icons: **Study**, **Work** (selected), **Personal**, **Health**.
  - Priority selection chips with color-coded status: **Low**, **Medium**, **High** (selected in Coral Red).
  - Dual action buttons: "Cancel" outline button and "Create Task" elevated primary button.

---

### Screen 3: Mark-Complete & Reactive Progress Update

![Figure 3: Task Completed State](screenshots/03_task_completed.png)

* **Visual Elements**:
  - User tapped `"Implement StatefulWidget with setState"`.
  - Checkbox instantly toggled to an Emerald Green circle with a crisp checkmark.
  - Title text dynamically converted to strikethrough typography (`TextDecoration.lineThrough`) with muted text color.
  - Header statistics automatically updated from `25%` to `50%` completion.
  - KPI counters re-evaluated: **Total: 5**, **Pending: 2**, **Completed: 3**.

---

### Screen 4: Segmented Completed Filter View

![Figure 4: Completed Tasks Filter View](screenshots/04_completed_filter.png)

* **Visual Elements**:
  - User selected the **Completed** tab in the filter segment bar.
  - Active pill indicator animated to **Completed** with badge count `3`.
  - The viewport filters out all pending tasks, rendering strictly completed items.
  - Confirms proper predicate filtering via `_tasks.where((t) => t.isCompleted)`.

---

### Screen 5: Delete Task with Interactive UNDO SnackBar

![Figure 5: Delete Task with Undo SnackBar](screenshots/05_delete_undo_snackbar.png)

* **Visual Elements**:
  - User tapped the trash icon on `"Review Dart OOP & Mixin concepts"`.
  - Item immediately disappears from the task list.
  - Floating `SnackBar` appears at the bottom with dark slate background and high contrast text: `"Deleted \"Review Dart OOP & Mixin concepts\""`.
  - High-visibility amber **UNDO** action button allowing one-tap restoration of the removed task.
  - Progress counters recalculate to reflect the adjusted total count.

---

## 7. Verification & Automated Testing

### 7.1 Static Code Analysis

Static analysis was performed using Dart analyzer with `package:flutter_lints`:

```bash
cd /Users/virshin/VScode/Cross-App/Assignments/todo_app
flutter analyze
```

**Output**:
```text
Analyzing todo_app...
No issues found! (ran in 2.4s)
```
- Zero compilation errors.
- Zero deprecation warnings.
- 100% compliant with strict sound null safety.

### 7.2 Widget Test Suite (`test/widget_test.dart`)

An automated test suite was implemented to verify all user flows headlessly:

```bash
flutter test
```

**Test Execution Output**:
```text
00:00 +0: loading test/widget_test.dart
00:00 +0: TodoApp renders initial tasks and overview statistics
00:00 +1: Mark-complete operation toggles task completion state
00:00 +2: Add operation creates a new task via bottom sheet
00:01 +3: Delete operation removes a task and supports Undo
00:01 +4: Filter segment bar updates active tasks view
00:01 +5: All tests passed!
```

### 7.3 Test Case Breakdown

1. **`TodoApp renders initial tasks and overview statistics`**:
   Verifies that `My Tasks` app bar, `Today's Overview` card, default sample tasks, and the `Add Task` FAB are rendered on launch.
2. **`Mark-complete operation toggles task completion state`**:
   Locates an incomplete task, simulates a user tap, triggers `pumpAndSettle()`, and asserts that the state and text decoration update accordingly.
3. **`Add operation creates a new task via bottom sheet`**:
   Taps `Add Task`, verifies modal sheet presentation, enters text into `TextField`, taps `Create Task`, and confirms the new task appears in the `SliverList`.
4. **`Delete operation removes a task and supports Undo`**:
   Taps the delete button on the first task, verifies that the item is removed from the view, asserts that the SnackBar displays the `UNDO` action, taps `UNDO`, and confirms that the task is restored.
5. **`Filter segment bar updates active tasks view`**:
   Taps the `Pending` chip and verifies completed tasks are hidden; taps the `Completed` chip and verifies pending tasks are hidden while completed items appear.

---

## 8. Compilation & Execution Instructions

### Prerequisites
- Flutter SDK `^3.47.0` (Dart SDK `^3.13.0`).
- Any supported platform (Android emulator, iOS simulator, macOS desktop, or Google Chrome).

### Running on Google Chrome (Web)
```bash
cd /Users/virshin/VScode/Cross-App/Assignments/todo_app
flutter run -d chrome
```

### Running on Connected Android Device or Emulator
```bash
cd /Users/virshin/VScode/Cross-App/Assignments/todo_app
flutter run -d emulator-5554
```

### Running on macOS Desktop
```bash
cd /Users/virshin/VScode/Cross-App/Assignments/todo_app
flutter run -d macos
```

---

## 9. Conclusion

The **FocusTrack Todo Application** satisfies all intermediate Flutter architectural standards. By leveraging `StatefulWidget` and `setState`, the application achieves responsive and deterministic state transitions across addition, deletion, completion, and multi-parameter filtering. Root workspace Dart concepts — including object modeling, collections, pattern matching, and sound null safety — are rigorously integrated into a clean, modular, and thoroughly tested codebase.
