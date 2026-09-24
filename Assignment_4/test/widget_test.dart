import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dashboard/main.dart';

void main() {
  // ======================================================
  // 1. DESKTOP VIEWPORT TEST (3-Pane Architecture)
  // ======================================================
  testWidgets('Desktop viewport renders 3-pane layout',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Verify Desktop 3-pane sections
    expect(find.text('System Overview'), findsOneWidget);
    expect(find.text('Active Repositories & Modules'), findsOneWidget);
    expect(find.text('Live Activity'), findsOneWidget);
    expect(find.text('Cross-App Multiplatform Suite'), findsOneWidget);
  });

  // ======================================================
  // 2. TABLET VIEWPORT TEST (2-Pane Rail Architecture)
  // ======================================================
  testWidgets('Tablet viewport renders compact rail layout',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Verify Tablet 2-pane sections
    expect(find.text('System Overview'), findsOneWidget);
    expect(find.text('Active Repositories & Modules'), findsOneWidget);
    expect(find.text('Activity Stream'), findsOneWidget);
  });

  // ======================================================
  // 3. MOBILE VIEWPORT TEST (Single-Column + Drawer)
  // ======================================================
  testWidgets('Mobile viewport renders single-column layout with drawer',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Verify Mobile Single-Column sections
    expect(find.text('Cross-App Board'), findsOneWidget);
    expect(find.text('System Overview'), findsOneWidget);
    expect(find.text('Active Repositories & Modules'), findsOneWidget);
    expect(find.text('Activity Stream'), findsOneWidget);
  });

  // ======================================================
  // 4. NAVIGATION TEST (Open Detail Screen & Pop Back)
  // ======================================================
  testWidgets('Tapping project card opens ProjectDetailScreen and navigates back',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Tap on first project card
    await tester.tap(find.text('Cross-App Multiplatform Suite').first);
    await tester.pumpAndSettle();

    // Verify ProjectDetailScreen is displayed
    expect(find.text('Project Overview'), findsOneWidget);
    expect(find.text('Sprint Progress'), findsOneWidget);
    expect(find.text('Done & Return'), findsOneWidget);

    // Pop back using the AppBar back icon
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    // Verify returned to Dashboard
    expect(find.text('System Overview'), findsOneWidget);
  });

  // ======================================================
  // 5. FILTERING TEST (Category Chips)
  // ======================================================
  testWidgets('Category filter chips update displayed projects',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Tap 'Cloud Architecture' filter chip
    await tester.tap(find.text('Cloud Architecture').first);
    await tester.pumpAndSettle();

    // Verify Serverless Real-Time Sync Engine is shown
    expect(find.text('Serverless Real-Time Sync Engine'), findsOneWidget);
    // Verify item count changed
    expect(find.text('1 Items'), findsOneWidget);
  });

  // ======================================================
  // 6. SIDEBAR FILTER TEST (Overview vs Bookmarked)
  // ======================================================
  testWidgets('Sidebar switches between Overview and Bookmarked repositories',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ResponsiveDashboardApp());
    await tester.pumpAndSettle();

    // Tap Bookmarked in sidebar
    await tester.tap(find.text('Bookmarked'));
    await tester.pumpAndSettle();

    // Verify heading switched to Bookmarked Repositories
    expect(find.text('Bookmarked Repositories'), findsOneWidget);

    // Tap Overview to switch back
    await tester.tap(find.text('Overview'));
    await tester.pumpAndSettle();

    // Verify heading switched back
    expect(find.text('Active Repositories & Modules'), findsOneWidget);
  });
}
