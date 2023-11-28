import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/form_header_login.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_footer_widget.dart';
import 'package:zest_trip/features/authentication/presentation/widgets/login_form_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          state.user!.isRecommendRracked!
              ? Navigator.of(context).pushReplacementNamed(AppRoutes.home)
              : Navigator.of(context).pushReplacementNamed(AppRoutes.hobby);
        }
        if (state is AuthFailure) {
          Fluttertoast.showToast(
              msg: state.error?.response?.data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      buildWhen: (previous, current) => previous != current,
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
                onPressed: () async {
                  const secureStorage = FlutterSecureStorage();
                  await secureStorage.delete(key: 'access_token');
                  await secureStorage.delete(key: 'refresh_token');
                  Navigator.of(context).pushNamed(AppRoutes.home);
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
