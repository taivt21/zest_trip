import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              //  Gọi sự kiện đăng nhập bằng Google
              BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
            },
            icon: const Image(
              image: AssetImage(tGoogleLogoImage),
              width: 20.0,
            ),
            label: const Text(tSignInWithGoogle),
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to the sign-up screen
            Navigator.pushNamed(context, AppRoutes.login);
          },
          child: const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: tAlreadyHaveAnAccount,
                  style: AppTextStyles.body,
                ),
                TextSpan(
                    text: tLogin,
                    style: TextStyle(color: Colors.blue, fontSize: 16))
              ],
            ),
          ),
        )
      ],
    );
  }
}
