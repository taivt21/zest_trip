import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Đặt các input field cho email, password, fullName, dob, gender ở đây
            // Ví dụ:
            // TextField(
            //   decoration: InputDecoration(labelText: 'Email'),
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Password'),
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Họ và tên'),
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Ngày sinh'),
            // ),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Giới tính'),
            // ),
            // Nút đăng ký
            ElevatedButton(
              onPressed: () {
                // Gọi sự kiện đăng ký ở đây
              },
              child: const Text('Đăng ký'),
            ),
            // Nút đăng nhập bằng Google
            ElevatedButton(
              onPressed: () {
                // Gọi sự kiện đăng nhập bằng Google ở đây
              },
              child: const Text('Đăng nhập bằng Google'),
            ),
          ],
        ),
      ),
    );
  }
}
