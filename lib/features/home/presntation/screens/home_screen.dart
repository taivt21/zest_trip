import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/tour_bloc_ex.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/home/presntation/screens/profile_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/secondary_screen.dart';
import 'package:zest_trip/features/home/presntation/screens/trips_screen.dart';
import 'package:zest_trip/get_it.dart';
import './wishlist_screen.dart';

const List<Widget> bottomNavScreen = <Widget>[
  SecondaryScreen(),
  WishlistScreen(),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteTourBloc>(
          create: (context) => sl()..add(const GetTours()),
        ),
        BlocProvider<TourTagBloc>(
          create: (context) => sl()..add(const GetTourTags()),
        ),
        BlocProvider<TourVehicleBloc>(
          create: (context) => sl()..add(const GetTourVehicles()),
        ),
      ],
      child: SafeArea(
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
                icon: Icon(Icons.history_edu_outlined),
                label: 'Trips',
              ),
              // NavigationDestination(
              //   icon: Icon(Icons.chat_outlined),
              //   label: 'Chat',
              // ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
          body: IndexedStack(
            index: currentPageIndex,
            children: bottomNavScreen,
          ),
        ),
      ),
    );
  }
}
