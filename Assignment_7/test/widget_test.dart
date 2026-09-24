import 'package:assignments/main.dart';
import 'package:assignments/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen renders and navigates to Registration screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AssignmentApp());
    await tester.pumpAndSettle();

    // Verify Home screen content
    expect(find.text('Nexus ID'), findsOneWidget);
    expect(find.text('Next-Gen Identity &\nDigital Workspace'), findsOneWidget);
    expect(find.byKey(const Key('register_button')), findsOneWidget);

    // Tap register button
    await tester.tap(find.byKey(const Key('register_button')));
    await tester.pumpAndSettle();

    // Verify Registration screen loaded
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.byKey(const Key('name_field')), findsOneWidget);
    expect(find.byKey(const Key('email_field')), findsOneWidget);
    expect(find.byKey(const Key('password_field')), findsOneWidget);
  });

  testWidgets('Registration form validates required fields and regexes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AssignmentApp());
    await tester.pumpAndSettle();

    // Navigate to registration screen
    await tester.tap(find.byKey(const Key('register_button')));
    await tester.pumpAndSettle();

    // Tap submit on empty form
    await tester.ensureVisible(find.byKey(const Key('submit_button')));
    await tester.tap(find.byKey(const Key('submit_button')));
    await tester.pumpAndSettle();

    // Check required validation errors
    expect(find.text('Full name is required'), findsOneWidget);
    expect(find.text('Email address is required'), findsOneWidget);
    expect(find.text('Phone number is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('You must accept the terms before submitting.'), findsOneWidget);

    // Wait for the SnackBar to dismiss so it does not obscure the submit button
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // Enter invalid email and weak password
    await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('email_field')),
          matching: find.byType(TextFormField),
        ),
        'invalid-email');
    await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('password_field')),
          matching: find.byType(TextFormField),
        ),
        '123');

    await tester.ensureVisible(find.byKey(const Key('submit_button')));
    await tester.tap(find.byKey(const Key('submit_button')));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email address (e.g. user@domain.com)'),
        findsOneWidget);
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });

  testWidgets('Registration form completes successfully and passes data to Detail screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AssignmentApp());
    await tester.pumpAndSettle();

    // Navigate to registration screen
    await tester.tap(find.byKey(const Key('register_button')));
    await tester.pumpAndSettle();

    // Fill valid data
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('name_field')),
        matching: find.byType(TextFormField),
      ),
      'Virshin Kumar',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('email_field')),
        matching: find.byType(TextFormField),
      ),
      'virshin@example.com',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('phone_field')),
        matching: find.byType(TextFormField),
      ),
      '9876543210',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('password_field')),
        matching: find.byType(TextFormField),
      ),
      'StrongP@ss1',
    );
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('confirm_password_field')),
        matching: find.byType(TextFormField),
      ),
      'StrongP@ss1',
    );

    // Check terms checkbox
    await tester.ensureVisible(find.byKey(const Key('terms_checkbox')));
    await tester.tap(find.byKey(const Key('terms_checkbox')));
    await tester.pumpAndSettle();

    // Submit form
    await tester.ensureVisible(find.byKey(const Key('submit_button')));
    await tester.tap(find.byKey(const Key('submit_button')));
    // Wait for submission animation and navigation transition
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify Detail screen
    expect(find.text('Member Profile'), findsOneWidget);
    expect(find.text('Virshin Kumar'), findsWidgets);
    expect(find.text('virshin@example.com'), findsWidgets);
    expect(find.text('9876543210'), findsOneWidget);
    expect(find.text('VK'), findsOneWidget); // Initials
    expect(find.text('Verified Profile'), findsOneWidget);

    // Return to home screen
    await tester.ensureVisible(find.byKey(const Key('back_to_home_button')));
    await tester.tap(find.byKey(const Key('back_to_home_button')));
    await tester.pumpAndSettle();

    // Back on Home screen
    expect(find.text('Nexus ID'), findsOneWidget);
  });

  testWidgets('Detail screen handles empty arguments gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DetailScreen(user: null),
    ));
    await tester.pumpAndSettle();

    expect(find.text('No Profile Data Found'), findsOneWidget);
    expect(find.text('Return to Home'), findsOneWidget);
  });
}
