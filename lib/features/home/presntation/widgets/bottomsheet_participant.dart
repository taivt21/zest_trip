import 'package:flutter/material.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';

class ParticipantBottomSheet extends StatelessWidget {
  const ParticipantBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Edit participants details',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: UnderlineInputBorder(),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: UnderlineInputBorder(),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Note',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButtonCustom(
          onPressed: () {},
          text: "Save",
        ),
      ],
    );
  }
}
