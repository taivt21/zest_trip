import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/size_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();

    logger.i('render footer');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
            onPressed: () {
              // Gọi sự kiện đăng nhập bằng Google ở đây
              context.read<AuthBloc>().add(SignInWithGoogleEvent());
            },
            label: const Text(tSignInWithGoogle),
          ),
          //     OutlinedButtonCustom(
          //   text: tSignInWithGoogle,
          //   onPressed: () {
          //     BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
          //   },
          //   iconData: Icons.mail,
          // ),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () {
            // Navigate to the sign-up screen
            Navigator.pushNamed(context, AppRoutes.signup);
          },
          child: const Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: AppTextStyles.body,
                children: [
                  TextSpan(text: tSignup, style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
