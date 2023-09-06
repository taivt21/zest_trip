import 'package:flutter/material.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final List<AuthUser> users = [
    const AuthUser(fullName: "user 1"),
    const AuthUser(fullName: "user 2"),
    const AuthUser(fullName: "user 3"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // Điều chỉnh độ sâu của bóng đổ
                ),
              ],
            ),
            child: ListTile(
                title: Text(
                  user.fullName!,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.blue,
                  child: Text(
                    user.fullName![0],
                    style: const TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.conversation);
                }),
          );
        },
      ),
    );
  }
}
