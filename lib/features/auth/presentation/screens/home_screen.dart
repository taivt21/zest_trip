import 'package:flutter/material.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chào mừng'),
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
