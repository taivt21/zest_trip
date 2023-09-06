import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/size_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/signup_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(AppRoutes.login);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Register success! Login now')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: const Column(
              children: [
                FormHeaderWidget(),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
