import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/review_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';

class CardTourManage extends StatelessWidget {
  const CardTourManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    homeSvg,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text("Tour Provider"),
                ],
              ),
              const Text("Done")
            ],
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          const TourCard(
              tourName: "Ben tre",
              imageUrl:
                  "https://mod-movers.com/wp-content/uploads/2020/06/webaliser-_TPTXZd9mOo-unsplash-scaled-e1591134904605.jpg",
              price: "20000000"),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total: 550000"),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReviewScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Review",
                  style: TextStyle(color: whiteColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
