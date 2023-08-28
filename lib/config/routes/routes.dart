import 'package:flutter/material.dart';
import 'package:zest_trip/features/authentication/presentation/screens/login_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/signup_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/wishlist_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboard = '/';
  static const String home = '/home';

  static const String logout = '/logout';
  static const String wishlist = '/wishlist';
  static const String order = '/order';
  static const String chat = '/chat';
  static const String tourDetail = '/tour_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case onboard:
        return MaterialPageRoute(builder: (context) => const OnboardScreen());
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case wishlist:
        return MaterialPageRoute(builder: (context) => const WishlistScreen());

      // case order:
      //   return MaterialPageRoute(builder: (context) => const OrderScreen());
      // case chat:
      //   return MaterialPageRoute(builder: (context) => const ChatScreen());
      // Add more ...
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
