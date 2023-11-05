import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/manage_review_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  int userRating = 0;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TourCard(
                tourName: 'Ben tre',
                imageUrl:
                    'https://mod-movers.com/wp-content/uploads/2020/06/webaliser-_TPTXZd9mOo-unsplash-scaled-e1591134904605.jpg',
                price: '2.500.000.000 ',
              ),
              const Text(
                'Share your experience',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              buildStarRating(),
              const SizedBox(height: 20),
              const Text(
                'Your feedback:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              buildCommentTextField(),
              const SizedBox(height: 20),
              ElevatedButtonCustom(
                onPressed: () {
                  submitReview();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageReviewScreen()));
                },
                text: "Submit Review",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStarRating() {
    return Row(
      children: [
        ...List.generate(
          5,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                userRating = index + 1;
              });
            },
            child: Row(
              children: [
                Icon(
                  index < userRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            getRatingText(userRating),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
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

  Widget buildCommentTextField() {
    return TextField(
      controller: commentController,
      maxLines: 6,
      maxLength: 1000,
      decoration: const InputDecoration(
        hintText: 'Please share your feedback on this service!',
        hintStyle: TextStyle(color: colorHint),
        filled: true,
        fillColor: colorBackground,
        border: OutlineInputBorder(),
      ),
      onEditingComplete: () {
        if (commentController.text.length < 20) {
          debugPrint('Please enter at least 20 characters.');
        } else {
          debugPrint('Comment submitted: ${commentController.text}');
        }
      },
    );
  }

  void submitReview() {
    debugPrint('Rating: $userRating');
    debugPrint('Comment: ${commentController.text}');
    context.read<TourReviewsBloc>().add(PostReview(commentController.text,
        userRating, "1a5607a8-9a70-4731-be02-30df4c1c1676"));
  }
}
