import 'package:flutter/material.dart';
import 'package:zest_trip/features/authentication/presentation/screens/login_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/signup_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/conversation_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/wishlist_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String home = '/home';

  static const String logout = '/logout';
  static const String wishlist = '/wishlist';
  static const String order = '/order';
  static const String chat = '/chat';
  static const String conversation = '/conversation';
  static const String tourDetail = '/tour_detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _materialRoute(const LoginScreen());
      case signup:
        return _materialRoute(const SignUpScreen());
      case main:
        return _materialRoute(const MainScreen());
      case home:
        return _materialRoute(
          const HomeScreen(),
        );
      case conversation:
        return _materialRoute(const ConversationScreen());
      case wishlist:
        return _materialRoute(
          const WishlistScreen(),
        );

      // case order:
      //   return MaterialPageRoute(builder: (context) => const OrderScreen());
      // case chat:
      //   return MaterialPageRoute(builder: (context) => const ChatScreen());
      // Add more ...
      default:
        return _materialRoute(
          const HomeScreen(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => view);
  }
}
