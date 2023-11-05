import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header_login.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
        if (state is AuthFailure) {
          Fluttertoast.showToast(
              msg: "Oops, login failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        Widget contentWidget;

        if (state is AuthLoading) {
          contentWidget = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          contentWidget = SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(spaceBody),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormHeaderLoginWidget(),
                  LoginFormWidget(),
                  LoginFooterWidget(),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Login"),
            centerTitle: true,
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
                  Navigator.of(context).pushNamed(AppRoutes.home),
                },
              ),
            ],
          ),
          body: contentWidget,
        );
      },
    );
  }
}
