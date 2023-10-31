import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presentation/widgets/reply_of_provider.dart';

class UserReview extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final int starRating;
  final String description;
  final DateTime reviewDateTime;
  final List<ReplyOfProvider> replies;

  const UserReview({
    Key? key,
    required this.avatarUrl,
    required this.userName,
    required this.starRating,
    required this.description,
    required this.reviewDateTime,
    this.replies = const [],
  }) : super(key: key);

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
                backgroundImage: NetworkImage(avatarUrl),
                radius: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildStarRating(),
              const SizedBox(width: 8.0),
              Text(
                _getFormattedDate(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(description),
          const SizedBox(height: 8.0),
          // Display replies
          ...replies,
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < starRating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20.0,
        ),
      ),
    );
  }

  String _getFormattedDate() {
    return "${reviewDateTime.day}/${reviewDateTime.month}/${reviewDateTime.year}";
  }
}
