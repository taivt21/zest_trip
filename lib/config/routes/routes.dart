import 'package:flutter/material.dart';
import 'package:zest_trip/features/auth/presentation/screens/login_screen.dart';
import 'package:zest_trip/features/auth/presentation/screens/signup_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      // Add more ...
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
