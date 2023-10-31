import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';

class FormHeaderSignupWidget extends StatelessWidget {
  const FormHeaderSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Create your ',
            style: Theme.of(context).textTheme.titleLarge,
            children: const <TextSpan>[
              TextSpan(
                text: 'free ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              TextSpan(
                text: 'account',
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          registerSvg,
          height: 250,
        ),
      ],
    );
  }
}
