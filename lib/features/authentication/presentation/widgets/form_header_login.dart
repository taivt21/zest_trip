import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';

class FormHeaderLoginWidget extends StatelessWidget {
  const FormHeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Welcome to ',
            style: Theme.of(context).textTheme.titleLarge,
            children: const <TextSpan>[
              TextSpan(
                text: 'ZEST TRAVEL!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          loginSvg,
          height: 250,
        ),
      ],
    );
  }
}
