// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/profile_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/trips_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/wishlist_screen.dart';

const List<Widget> bottomNavScreen = [
  MainScreen(),
  WishlistScreen(),
  TripsScreen(),
  // ChatScreen(),
  ProfileScreen(),
];

class HomeScreen extends StatefulWidget {
  final int? initialPageIndex;
  const HomeScreen({
    Key? key,
    this.initialPageIndex = 0,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.blue[100],
          selectedIndex: currentPageIndex,
          animationDuration: const Duration(microseconds: 1000),
          destinations: [
            NavigationDestination(
              selectedIcon: SvgPicture.asset(
                homeSvg,
                height: 24,
                width: 24,
              ),
              icon: SvgPicture.asset(
                homeSvg,
                height: 24,
                width: 24,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                heartSvg,
                height: 24,
                width: 24,
              ),
              label: 'Wishlist',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                tripSvg,
                height: 24,
                width: 24,
              ),
              label: 'Bookings',
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.chat_outlined),
            //   label: 'Chat',
            // ),
            NavigationDestination(
              icon: SvgPicture.asset(
                profileSvg,
                height: 24,
                width: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body:
            // IndexedStack(
            //   index: currentPageIndex,
            //   children: bottomNavScreen,
            // ));
            bottomNavScreen[currentPageIndex]);
  }
}
