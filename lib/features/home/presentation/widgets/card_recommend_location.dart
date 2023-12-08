// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class CardRecommendLocation extends StatelessWidget {
  const CardRecommendLocation({
    Key? key,
    required this.tour,
    this.heightImage,
    required this.width,
  }) : super(key: key);

  final TourEntity tour;
  final double? heightImage;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: colorLightGrey!),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: tour.tourImages![0],
                width: width,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colorPlaceHolder,
                  width: width,
                  height: 120,
                ),
                errorWidget: (context, url, error) => Container(
                  color: colorPlaceHolder,
                  width: width,
                  height: 120,
                ),
              ),
            ),
          ),
          Container(
            width: width,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.name ?? "Tour name",
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (tour.avgRating != null && tour.count?["TourReview"] != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 12),
                      const SizedBox(width: 4),
                      Text(
                        tour.avgRating!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.yellow[700],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " (${tour.count?["TourReview"]})",
                        style: TextStyle(color: colorBoldGrey),
                      ),
                    ],
                  ),
                Text(
                  "${tour.count?["Booking"]} booked",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400, color: colorBlack),
                ),
                // if (tour.pricingTicket?[0].fromPrice != null)
                // Text(
                //   "${NumberFormatter.format(num.parse(tour.pricingTicket![0].fromPrice!))} ₫",
                //   style: Theme.of(context).textTheme.titleMedium,
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
