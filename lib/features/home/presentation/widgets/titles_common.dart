
import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class Titles extends StatelessWidget {
  final String title;
  const Titles({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 4,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ],
    );
  }
}
