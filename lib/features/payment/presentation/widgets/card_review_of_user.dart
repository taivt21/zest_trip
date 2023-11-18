// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';

class CardReviewOfUser extends StatelessWidget {
  final TourReviewEntity review;
  const CardReviewOfUser({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
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
              Text(
                "${review.status}",
                style: const TextStyle(color: colorSuccess),
              )
            ],
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${review.tourId} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //     "${DateFormat('dd MMM yyyy').format(review.bookedDate!)} ${invoice.timeSlot} (Local time)",
                    //     style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    // Column(
                    //   children: review.ticketOnBooking!.map((ticket) {
                    //     return Text(
                    //       "x${ticket.quantity} ${ticket.ticketTypeId == 1 ? 'Adult' : 'Children'}",
                    //       style: Theme.of(context).textTheme.bodyMedium,
                    //     );
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 3,
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 8),
              //     height: 80,
              //     width: 80,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage("${review.tour!["tour_images"][0]}"),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          const Divider(
            color: colorPlaceHolder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Row(
              //       children: [
              //         const Text("Price: "),
              //         Text(
              //           "${NumberFormat("#,###").format(num.parse(review.originalPrice!))} ₫",
              //           // style: Theme.of(context)
              //           //     .textTheme
              //           //     .bodySmall
              //           //     ?.copyWith(
              //           //         decoration: TextDecoration.lineThrough),
              //         ),
              //       ],
              //     ),
              //     Text(
              //         "Paid: ${NumberFormat("#,###").format(num.parse(review.paidPrice!))} ₫"),
              //   ],
              // ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const ReviewScreen(),
                      //   ),
                      // );
                    },
                    child: const Text(
                      "Refund",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: const StadiumBorder()),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ReviewScreen(
                      //         tourId: invoice.tourId!,
                      //         image: invoice.tour!["tour_images"][0],
                      //         location: invoice.tour!["address_province"],
                      //         paid: invoice.paidPrice!,
                      //         tourName: invoice.tour!["name"]),
                      //   ),
                      // );
                    },
                    child: const Text(
                      "Review",
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
