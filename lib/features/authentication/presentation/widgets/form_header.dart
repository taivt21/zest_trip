import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const storage = FlutterSecureStorage();
    return Center(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Welcome to \n',
              style: Theme.of(context).textTheme.headlineLarge,
              children: const <TextSpan>[
                TextSpan(
                  text: 'ZEST TRIP!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primaryColor),
                ),
              ],
            ),
          ),
          ElevatedButtonCustom(
            text: "Guest",
            onPressed: () => {
              storage.deleteAll(),
              Navigator.of(context).pushNamed(AppRoutes.home),
            },
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
