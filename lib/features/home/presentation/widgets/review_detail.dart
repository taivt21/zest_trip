import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';

class ReviewWidget extends StatelessWidget {
  final TourReviewEntity? tourReviews;
  const ReviewWidget({
    super.key,
    required this.tourReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: colorLightGrey!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      "${tourReviews?.user?.avatarImageUrl}"),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  tourReviews?.user?.fullName ?? "Anonymous",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < tourReviews!.rating!.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.yellow,
                );
              }),
            ),
            const SizedBox(height: 4),
            Text(
              "${tourReviews!.description}",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
