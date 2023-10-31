import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presentation/widgets/reply_of_provider.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';

class ReviewsOfTour extends StatelessWidget {
  const ReviewsOfTour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All reviews"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            UserReview(
              avatarUrl:
                  'https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg',
              userName: 'John Doe',
              starRating: 4,
              description: 'Great service! I highly recommend it.',
              reviewDateTime: DateTime.now(),
              replies: [
                ReplyOfProvider(
                  avatarUrl:
                      'https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg',
                  userName: 'Jane Doe',
                  replyText: 'Thank you!',
                  replyDateTime: DateTime.now(),
                ),
              ],
            ),
            UserReview(
              avatarUrl:
                  'https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg',
              userName: 'John Doe',
              starRating: 4,
              description: 'Great service! I highly recommend it.',
              reviewDateTime: DateTime.now(),
            ),
          ]),
        ),
      ),
    );
  }
}
