import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/core/constants/size_constant.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_event.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/auth/presentation/widgets/login_footer_widget.dart';
import 'package:zest_trip/features/auth/presentation/widgets/login_form_widget.dart';
import 'package:zest_trip/features/auth/presentation/widgets/form_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Login',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              // Xử lý hiển thị khi đang xử lý đăng nhập
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthSuccess) {
              // Chuyển hướng đến trang HomeScreen khi đăng nhập thành công
              return Column(
                children: [
                  Text('Email của bạn là: ${state.user.email}'),
                  ElevatedButton(
                    onPressed: () {
                      // Gọi sự kiện Logout ở đây
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            } else if (state is AuthFailure) {
              // Xử lý hiển thị khi đăng nhập thất bại
              return Center(
                child: Text('Đăng nhập thất bại: ${state.errorMessage}'),
              );
            } else {
              // Trạng thái AuthInitial hoặc trạng thái không xác định
              // Hiển thị giao diện đăng nhập và nút đăng nhập Google

              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHeaderWidget(),
                          LoginFormWidget(),
                          LoginFooterWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
