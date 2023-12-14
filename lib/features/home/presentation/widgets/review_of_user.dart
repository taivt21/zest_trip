import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/presentation/widgets/reply_of_provider.dart';

class UserReview extends StatefulWidget {
  final TourReviewEntity tourReview;

  const UserReview({Key? key, required this.tourReview}) : super(key: key);

  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  widget.tourReview.user?.avatarImageUrl ??
                      "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
                ),
                backgroundColor: whiteColor,
                radius: 20.0,
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tourReview.user?.fullName ??
                        widget.tourReview.user!.email!.split('@').first,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    _getFormattedDate(),
                    style: const TextStyle(
                      color: colorHint,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          _buildStarRating(),
          const SizedBox(height: 8.0),
          Text(
            widget.tourReview.description ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          // Display replies
          if (widget.tourReview.reply != null && isExpanded)
            ReplyOfProvider(providerReplyEntity: widget.tourReview.reply!),
          const SizedBox(height: 8.0),
          if (widget.tourReview.reply != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Hide Replies' : 'View Replies',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: [
        Row(
          children: List.generate(
            5,
            (index) => Icon(
              index < widget.tourReview.rating!
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              color: Colors.amber,
              size: 20.0,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          getRatingText(widget.tourReview.rating!),
          style: const TextStyle(
            color: colorHint,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  String _getFormattedDate() {
    return "${widget.tourReview.createdAt!.day}/${widget.tourReview.createdAt!.month}/${widget.tourReview.createdAt!.year}";
  }

  String getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Terrible';
      case 2:
        return 'Not Satisfied';
      case 3:
        return 'Okay';
      case 4:
        return 'Satisfied';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
}
