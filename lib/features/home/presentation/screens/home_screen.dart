import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/main_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/profile_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/trips_screen.dart';

const List<Widget> bottomNavScreen = <Widget>[
  MainScreen(),
  // WishlistScreen(),
  TripsScreen(),
  // ChatScreen(),
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
          destinations: <Widget>[
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
            // NavigationDestination(
            //   icon: SvgPicture.asset(
            //     heartSvg,
            //     height: 24,
            //     width: 24,
            //   ),
            //   label: 'Wishlist',
            // ),
            NavigationDestination(
              icon: SvgPicture.asset(
                tripSvg,
                height: 24,
                width: 24,
              ),
              label: 'Trips',
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
        body: IndexedStack(
          index: currentPageIndex,
          children: bottomNavScreen,
        ),
      ),
    );
  }
}
