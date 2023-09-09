import 'package:flutter/material.dart';
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  // Assuming tourImages is a list of URLs
                  imageUrl: tour.tourImages![0],
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Color.fromARGB(255, 126, 124, 124),
                  ),
                  onPressed: () {
                    // BlocProvider.of<RemoteTourBloc>(context)
                    //     .add(AddToWishlist(tour.id!));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tour.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.black, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '4.5', // Replace with the actual rating value
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '\$${tour.price}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${tour.durationDay} days',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      // ),
    );
  }
}
