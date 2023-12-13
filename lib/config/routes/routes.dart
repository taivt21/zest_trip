import 'package:flutter/material.dart';
import 'package:zest_trip/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/login_screen.dart';
import 'package:zest_trip/features/authentication/presentation/screens/signup_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/home_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/manage_review_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/search_location_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/search_query_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/secondary_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/select_hobby_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/wishlist_screen.dart';
import 'package:zest_trip/features/payment/presentation/screens/thanks_booking.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String home = '/home';
  static const String hobby = '/hobby';

  static const String logout = '/logout';
  static const String wishlist = '/wishlist';
  static const String manageReview = '/manageReview';
  static const String tourDetail = '/tourDetail';
  static const String order = '/order';
  static const String chat = '/chat';
  static const String otp = '/otp';
  static const String forgetPassword = '/forget_password';
  static const String landingScreen = '/landing';
  static const String thanksBooking = '/thanks';
  static const String searchQuery = '/searchQuery';
  static const String searchLocation = '/searchLocation';
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
      case hobby:
        return _materialRoute(
          const SelectHobbyScreen(),
        );
      case landingScreen:
        return _materialRoute(
          const SecondaryScreen(),
        );
      case thanksBooking:
        return _materialRoute(
          const ThankYouPage(title: "Thanks for booking"),
        );
      // case conversation:
      //   return _materialRoute(const ConversationScreen());
      case wishlist:
        return _materialRoute(
          const WishlistScreen(),
        );
      case manageReview:
        return _materialRoute(
          const ManageReviewScreen(),
        );
      case searchLocation:
        return _materialRoute(
          const SearchLocationScreen(),
        );
      case searchQuery:
        return _materialRoute(
          const SearchQueryScreen(),
        );
      // case tourDetail:
      //   return _materialRoute(
      //     const TourDetailScreen(tourId: ),
      //   );

      case forgetPassword:
        return _materialRoute(
          const ForgetPasswordScreen(),
        );
      default:
        return _materialRoute(
          const LoginScreen(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (context) => view);
  }
}
