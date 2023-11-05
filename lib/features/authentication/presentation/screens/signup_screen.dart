import 'package:flutter/material.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header_signup.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/signup_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            child: Text(
              "Guest",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(decoration: TextDecoration.underline),
            ),
            onPressed: () => {
              Navigator.of(context).pushNamed(AppRoutes.login),
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(spaceBody),
          child: const Column(
            children: [
              FormHeaderSignupWidget(),
              SignUpFormWidget(),
              SignUpFooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
