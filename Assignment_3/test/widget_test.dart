import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profile/main.dart';

void main() {
  testWidgets('Profile card renders required widgets and content',
      (WidgetTester tester) async {
    // Build ProfileApp and trigger a frame
    await tester.pumpWidget(const ProfileApp());

    // Verify all requested widgets are present in the widget tree:
    // Column, Row, Container, CircleAvatar, Text, Icon
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CircleAvatar), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(Icon), findsWidgets);

    // Verify key profile texts
    expect(find.text('Profile Card'), findsOneWidget);
    expect(find.text('R Virshin'), findsOneWidget);
    expect(find.text('Flutter & Mobile App Developer'), findsOneWidget);
    expect(find.text('Developer'), findsOneWidget);
    expect(find.text('Verified'), findsOneWidget);
    expect(find.text('150096724147'), findsOneWidget);
    expect(find.text('virshinkumar@gmail.com'), findsOneWidget);
    expect(find.text('+91 98765 43210'), findsOneWidget);
    expect(find.text('Bangalore, India'), findsOneWidget);
  });
}
