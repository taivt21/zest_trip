import 'package:flutter/material.dart';
import 'package:zest_trip/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/login_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/signup_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/secondary_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/wishlist_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String home = '/home';

  static const String logout = '/logout';
  static const String wishlist = '/wishlist';
  static const String order = '/order';
  static const String chat = '/chat';
  static const String otp = '/otp';
  static const String forgetPassword = '/forget_password';
  static const String landingScreen = '/landing';

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
      case landingScreen:
        return _materialRoute(
          const SecondaryScreen(),
        );
      // case conversation:
      //   return _materialRoute(const ConversationScreen());
      case wishlist:
        return _materialRoute(
          const WishlistScreen(),
        );

      case forgetPassword:
        return _materialRoute(
          const ForgetPasswordScreen(),
        );
      default:
        return _materialRoute(
          // BlocBuilder<AuthBloc, AuthState>(
          //   builder: (context, state) {
          //     if (state is AuthLoggedOut) {
          //       return const LoginScreen();
          //     } else if (state is AuthSuccess) {
          //       return const HomeScreen();
          //     } else {
          //       return const LoginScreen();
          //     }
          //   },
          // ),
          const LoginScreen(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => view);
  }
}
