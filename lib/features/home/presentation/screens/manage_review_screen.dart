import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour_manage.dart';

class ManageReviewScreen extends StatelessWidget {
  const ManageReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Review"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const CardTourManage(),
          Divider(
            color: colorHint.withOpacity(0.3),
            thickness: 8,
          ),
          const SizedBox(
            height: 4,
          ),
          const CardTourManage(),
        ]),
      ),
    );
  }
}
