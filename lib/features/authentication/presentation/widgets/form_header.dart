import 'package:flutter/material.dart';

import '../../../../config/utils/constants/text_constant.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image(
        //     image: const AssetImage(tWelcomeScreenImage),
        //     height: size.height * 0.1),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        // Text(tLoginSubTitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
