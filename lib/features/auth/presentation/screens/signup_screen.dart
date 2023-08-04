import 'package:flutter/material.dart';
import 'package:zest_trip/core/constants/size_constant.dart';
import 'package:zest_trip/features/auth/presentation/widgets/form_header.dart';
import 'package:zest_trip/features/auth/presentation/widgets/signup_footer_widget.dart';
import 'package:zest_trip/features/auth/presentation/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
