import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/dimension_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourItemWidget extends StatelessWidget {
  final TourEntity tour;

  const TourItemWidget({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(spaceItem),
      padding: const EdgeInsets.all(spaceItem),
      // margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              // Assuming tourImages is a list of URLs
              imageUrl: tour.tourImages![0],
              placeholder: (context, url) => Container(
                color: colorLightGrey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tour.name ?? "null",
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
          Text('${tour.addressCity}, ${tour.addressCountry}',
              style: Theme.of(context).textTheme.bodyMedium),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow[700], size: 12),
              const SizedBox(width: 4),
              Text('${tour.avgRating} ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.yellow[700], fontWeight: FontWeight.bold)),
              Text(
                style: const TextStyle(color: colorBlack),
                "(${tour.count?['TourReview']}) • ",
              ),
              Text(
                "${tour.count?['TourReview']} booked",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, color: colorBlack),
              ),
            ],
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
                text: "From ",
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: ' ${tour.pricingTicket![0].fromPrice}₫',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  )
                ]),
          ),
        ],
      ),
      // ),
    );
  }

  // int _getLastPrice(TourEntity tour) {
  //   var lastTicketPricing = tour.pricingTicket?.last;

  //   if (lastTicketPricing != null &&
  //       lastTicketPricing.priceRange != null &&
  //       lastTicketPricing.priceRange!.isNotEmpty) {
  //     var lastPriceRange = lastTicketPricing.priceRange!.last;
  //     return lastPriceRange.price ?? 0;
  //   }

  //   return 0;
  // }
}
