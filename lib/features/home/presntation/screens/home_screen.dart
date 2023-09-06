import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/repository/tour_repository_impl.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import './chat_screen.dart';
import './main_screen.dart';
import './order_screen.dart';
import './profile_screen.dart';
import './wishlist_screen.dart';

const List<Widget> bottomNavScreen = <Widget>[
  MainScreen(),
  WishlistScreen(),
  OrderScreen(),
  Chatscreen(),
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
  void initState() {
    super.initState();
  }

  final RemoteTourBloc tourBloc = RemoteTourBloc(
    GetTourUseCase(
      TourRepositoryImpl(TourRemoteDataSourceIml()),
    ),
  );
  final TourTagBloc tourTagBloc = TourTagBloc(
    GetTourTagsUseCase(
      TourRepositoryImpl(TourRemoteDataSourceIml()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //     providers: [
        //       BlocProvider<RemoteTourBloc>(
        //         create: (context) => tourBloc..add(const GetTours()),
        //       ),
        //       BlocProvider<TourTagBloc>(
        //         create: (context) => tourTagBloc..add(const GetTourTags()),
        //       )

        //       // BlocProvider(create: (BuildContext context) => authBloc),
        //     ],
        //     child:
        Scaffold(
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
      body: bottomNavScreen[currentPageIndex],
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
