import 'package:flutter/material.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';

class HomeScreen extends StatelessWidget {
  final AuthUser user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chào mừng ${user.fullName}'),
            Text('Email: ${user.email}'),
            // ElevatedButton(
            //   onPressed: () {
            //     // Đăng xuất
            //     BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            //   },
            //   child: const Text('Đăng xuất'),
            // ),
          ],
        ),
      ),
    );
  }
}
