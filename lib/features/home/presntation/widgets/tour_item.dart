import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourItemWidget extends StatelessWidget {
  final TourEntity tour;

  const TourItemWidget({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => TourDetailScreen(tour: tour),
        //       ),
        //     );
        //   },
        //   child:
        Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      // margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
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
                color: colorGrey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tour.name!,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
          Text('${tour.addressCity}, ${tour.addressCountry}',
              style: Theme.of(context).textTheme.bodyMedium),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow[800], size: 16),
              const SizedBox(width: 4),
              Text('4.5 ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.yellow[800], fontWeight: FontWeight.bold)),
              const Text(
                style: TextStyle(fontWeight: FontWeight.w300),
                "(22) • ",
              ),
              const Text(
                "400+ booked",
                style: TextStyle(fontWeight: FontWeight.w300),
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
                    text: '₫ ${tour.price},000',
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
}
