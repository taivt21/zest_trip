import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/core/constants/size_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_form_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.login);
          }
        },
        child: Scaffold(
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
            )));
  }
}
