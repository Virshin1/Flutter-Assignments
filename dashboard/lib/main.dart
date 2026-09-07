import 'package:flutter/material.dart';
import 'constants/app_palette.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const ResponsiveDashboardApp());
}

// ======================================================
// APPLICATION ROOT (Material 3 Theme Configuration)
// ======================================================
class ResponsiveDashboardApp extends StatelessWidget {
  const ResponsiveDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Developer Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          primary: AppPalette.primary,
          secondary: AppPalette.secondary,
          surface: AppPalette.surface,
        ),
        scaffoldBackgroundColor: AppPalette.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.surface,
          foregroundColor: AppPalette.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0.5,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
