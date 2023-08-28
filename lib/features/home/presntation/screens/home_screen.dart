import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presntation/screens/chat_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/order_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/profile_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/wishlist_screen.dart';

List<BottomNavigationBarItem> bottomNavItems =
    const <BottomNavigationBarItem>[];

const List<Widget> bottomNavScreen = <Widget>[
  OnboardScreen(),
  WishlistScreen(),
  OrderScreen(),
  ChatScreen(),
  ProfileScreen(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.blue[100],
          selectedIndex: currentPageIndex,
          animationDuration: const Duration(microseconds: 1000),
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Order',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_outlined),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          const OnboardScreen(),
          const WishlistScreen(),
          const OrderScreen(),
          const ChatScreen(),
          const ProfileScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
