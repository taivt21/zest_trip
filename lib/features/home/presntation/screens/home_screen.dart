import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/home/presntation/widgets/search_filed.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline),
    label: 'Wishlist',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.grid_3x3),
    label: 'Category',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  Text('Index 1: Wishlist'),
  Text('Index 2: Order'),
  Text('Index 3: Chat'),
  Text('Index 4: Profile'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              // Hiển thị thông tin từ state trên giao diện
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SearchfField(),

                    Text(
                        'Welcome, ${state.user.email}'), // Sử dụng thông tin user từ state
                  ],
                ),
              );
            } else {
              // Trạng thái không xác định hoặc AuthFailure
              return const Center(
                child: Text('Error loading user data.'),
              );
            }
          },
        ),
      ),
    );
  }
}
