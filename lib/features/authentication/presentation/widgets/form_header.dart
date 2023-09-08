import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Welcome to \n',
          style: Theme.of(context).textTheme.headlineLarge,
          children: const <TextSpan>[
            TextSpan(
                text: 'ZEST TRIP!',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: primaryColor)),
          ],
        ),
      ),
    );
  }
}
