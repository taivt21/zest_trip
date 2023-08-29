import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/size_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_form_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login success'),
            ));
            Navigator.of(context).pushNamed(AppRoutes.home);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login fail! Try again')));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            // Xử lý hiển thị khi đang xử lý đăng nhập
            logger.i('loading auth');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthFailure ||
              state is AuthLoading ||
              state is AuthInitial) {
            // Xử lý hiển thị khi đăng nhập thất bại
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
          } else {
            return const Center(
              child: Text('Some thing went wrong! '),
            );
          }
        },
      ),
    );
  }
}
