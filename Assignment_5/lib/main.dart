import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_palette.dart';
import 'screens/todo_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set transparent system status bar for seamless modern header
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const TodoApp());
}

/// Root Application Widget configuring theme and launching the TodoScreen.
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusTrack - Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          primary: AppPalette.primary,
          surface: AppPalette.surface,
        ),
        scaffoldBackgroundColor: AppPalette.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppPalette.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppPalette.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppPalette.cardBorder),
          ),
        ),
      ),
      home: const TodoScreen(),
    );
  }
}
