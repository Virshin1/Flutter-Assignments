import 'package:flutter/material.dart';
import 'constants/app_palette.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const ProductApp());
}

/// Root widget configuring the Material 3 application theme and initial route.
class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          primary: AppPalette.primary,
          secondary: AppPalette.secondary,
          surface: AppPalette.surface,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppPalette.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.surface,
          foregroundColor: AppPalette.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        cardTheme: CardThemeData(
          color: AppPalette.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppPalette.cardBorder, width: 1.2),
          ),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}
