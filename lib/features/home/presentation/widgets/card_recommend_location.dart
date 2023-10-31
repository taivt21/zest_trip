import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class CardRecommendLocation extends StatelessWidget {
  const CardRecommendLocation({
    Key? key,
    required this.width,
    this.height,
    required this.imageUrl,
    required this.title,
    required this.numberOfActivities,
    this.numberOfStars,
    this.numberOfReviews,
    this.price,
  }) : super(key: key);

  final double? height;
  final double width;
  final String imageUrl;
  final String title;
  final int? numberOfActivities;
  final double? numberOfStars;
  final int? numberOfReviews;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorLightGrey!),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (numberOfStars != null && numberOfReviews != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 12),
                        const SizedBox(width: 4),
                        Text('$numberOfStars',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.yellow[700],
                                    fontWeight: FontWeight.bold)),
                        Text(
                          " ($numberOfReviews)",
                          style: TextStyle(color: colorBoldGrey),
                        ),
                      ],
                    ),
                  Text(
                    "$numberOfActivities activities",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400, color: colorBlack),
                  ),
                  if (price != null)
                    Text(
                      "₫ $price",
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
