// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';

class ReviewScreen extends StatefulWidget {
  final String tourId;
  final String image;
  final String tourName;
  final String location;
  final String paid;
  const ReviewScreen({
    Key? key,
    required this.image,
    required this.tourName,
    required this.location,
    required this.paid,
    required this.tourId,
  }) : super(key: key);

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  int userRating = 0;
  TextEditingController commentController = TextEditingController();
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Review'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<MyReviewBloc, MyReviewState>(
        listener: (context, state) {
          if (state is ReviewFail) {
            Fluttertoast.showToast(
                msg: "${{state.error?.response?.data['message']}}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is ReviewSuccess) {
            Fluttertoast.showToast(
                msg: "Review success!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
            context.read<MyReviewBloc>().add(GetMyReview());

            Navigator.pop(
              context,
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            // decoration: const BoxDecoration(color: colorBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TourCard(
                  location: widget.location,
                  tourName: widget.tourName,
                  imageUrl: widget.image,
                  price: NumberFormatter.format(num.parse(widget.paid)),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButtonCustom(
            onPressed: () {
              setState(() {
                showError = true;
              });
              if (validateReview()) {
                submitReview();
              }
            },
            text: "Submit Review",
          ),
        ),
      ),
    );
  }

  bool validateReview() {
    return userRating != 0 && commentController.text.length >= 20;
  }

  Column buildStarRating() {
    return Column(
      children: [
        Row(
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
                      index < userRating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 32,
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
        ),
        if (showError && userRating == 0)
          const Column(
            children: [
              SizedBox(
                height: 4,
              ),
              Text(
                'Please provide a rating.',
                style: TextStyle(color: colorError),
              ),
            ],
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
      decoration: InputDecoration(
        hintText: 'Please share your feedback on this service!',
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
        errorText: showError && commentController.text.length < 20
            ? 'Please enter at least 20 characters.'
            : null,
      ),
      onEditingComplete: () {},
    );
  }

  void submitReview() {
    debugPrint('Rating: $userRating');
    debugPrint('Comment: ${commentController.text}');
    context
        .read<MyReviewBloc>()
        .add(PostReview(commentController.text, userRating, widget.tourId));

    context.read<MyReviewBloc>().add(GetMyReview());
  }
}
