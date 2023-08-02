
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_event.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/auth/presentation/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            // Xử lý hiển thị khi đang xử lý đăng nhập
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthSuccess) {
            // Chuyển hướng đến trang HomeScreen khi đăng nhập thành công
            return HomeScreen(user: state.user);
          } else if (state is AuthFailure) {
            // Xử lý hiển thị khi đăng nhập thất bại
            return Center(
              child: Text('Đăng nhập thất bại: ${state.errorMessage}'),
            );
          } else {
            // Trạng thái AuthInitial hoặc trạng thái không xác định
            // Hiển thị giao diện đăng nhập và nút đăng nhập Google
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Gọi sự kiện đăng nhập bằng email và password ở đây
                      BlocProvider.of<AuthBloc>(context).add(
                        const LoginWithEmailAndPasswordEvent(
                          email: 'your_email@example.com',
                          password: 'your_password',
                        ),
                      );
                    },
                    child: const Text('Đăng nhập'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Gọi sự kiện đăng nhập bằng Google ở đây
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignInWithGoogleEvent());
                    },
                    child: const Text('Đăng nhập bằng Google'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
