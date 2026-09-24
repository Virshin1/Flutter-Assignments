import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/registration_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String register = '/register';
  static const String detail = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegistrationScreen(),
        );

      case detail:
        final user = settings.arguments as UserModel?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DetailScreen(user: user),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No route defined for ${settings.name}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, home),
                    child: const Text('Return to Home'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
