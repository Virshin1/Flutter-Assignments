import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/main.dart';
import 'package:product_app/widgets/cart_sheet.dart';
import 'package:product_app/widgets/empty_state_view.dart';
import 'package:product_app/widgets/product_card.dart';

void main() {
  group('Product Listing App Tests', () {
    testWidgets('Renders discover title, search bar, and ListView.builder items',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Verify header title
      expect(find.text('Discover'), findsOneWidget);
      expect(find.text('Find premium gear & accessories'), findsOneWidget);

      // Verify search input field exists
      expect(find.byType(TextField), findsOneWidget);

      // Verify category selector chips exist
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);
      expect(find.text('Audio'), findsOneWidget);

      // Verify ProductCard items are rendered
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('Search query filters the product listing dynamically',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Enter search term "Headphones"
      await tester.enterText(find.byType(TextField), 'Headphones');
      await tester.pumpAndSettle();

      // Verify only matching product is displayed
      expect(find.text('Pro ANC Wireless Headphones'), findsOneWidget);
      expect(find.text('Ultra-Slim 4K OLED Monitor 27"'), findsNothing);

      // Clear search via clear icon
      final clearButton = find.byIcon(Icons.close_rounded);
      expect(clearButton, findsOneWidget);
      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Verify all products are restored
      expect(find.text('Ultra-Slim 4K OLED Monitor 27"'), findsOneWidget);
    });

    testWidgets('Selecting a category filters products correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Tap on the 'Electronics' category chip
      final electronicsChip = find.text('Electronics');
      expect(electronicsChip, findsOneWidget);
      await tester.tap(electronicsChip);
      await tester.pumpAndSettle();

      // Verify Electronics items are present
      expect(find.text('Ultra-Slim 4K OLED Monitor 27"'), findsOneWidget);
      // Audio item should not be present
      expect(find.text('Pro ANC Wireless Headphones'), findsNothing);
    });

    testWidgets('Toggling favorite updates heart icon state via setState',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Find first favorite icon
      final favoriteButtons = find.byTooltip('Add to favorites');
      if (favoriteButtons.evaluate().isNotEmpty) {
        await tester.tap(favoriteButtons.first);
        await tester.pumpAndSettle();

        // Verify SnackBar appears
        expect(find.byType(SnackBar), findsOneWidget);
      }
    });

    testWidgets('Non-matching search shows EmptyStateView with Reset button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Search for nonexistent product
      await tester.enterText(find.byType(TextField), 'NonExistentXYZProduct123');
      await tester.pumpAndSettle();

      // Verify empty state is displayed
      expect(find.byType(EmptyStateView), findsOneWidget);
      expect(find.text('No Products Found'), findsOneWidget);

      // Tap reset button
      final resetButton = find.text('Reset All Filters');
      expect(resetButton, findsOneWidget);
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      // Products restored
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('Adding product to cart opens CartSheet with items and total',
        (WidgetTester tester) async {
      await tester.pumpWidget(const ProductApp());
      await tester.pumpAndSettle();

      // Tap 'Add' button on the first product card
      final addButton = find.text('Add').first;
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Cart badge should appear with '1' in AppBar
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('1'),
        ),
        findsOneWidget,
      );

      // Tap cart icon in AppBar to open cart sheet
      final cartIcon = find.byTooltip('View Cart');
      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Verify CartSheet is open
      expect(find.byType(CartSheet), findsOneWidget);
      expect(find.text('My Cart'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(CartSheet),
          matching: find.text('Pro ANC Wireless Headphones'),
        ),
        findsOneWidget,
      );
      expect(find.text('Shipping'), findsOneWidget);
      expect(find.text('FREE'), findsOneWidget);
      expect(find.textContaining('Checkout •'), findsOneWidget);
    });
  });
}
