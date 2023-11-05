import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/reply_of_provider.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/get_it.dart';

class ReviewsOfTour extends StatelessWidget {
  final String tourId;
  const ReviewsOfTour({
    super.key,
    required this.tourId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TourReviewsBloc>(
      create: (context) => sl()..add(GetTourReviews(tourId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All reviews"),
        ),
        body: BlocBuilder<TourReviewsBloc, TourReviewsState>(
          builder: (context, state) {
            if (state is TourReviewsInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetReviewsSuccess) {
              // Build the UI based on the state of the bloc
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      for (var review in state.reviews!)
                        UserReview(
                          avatarUrl: review.user?.avatarImageUrl ?? "",
                          userName: review.user?.fullName ?? "anonymous",
                          starRating: review.rating ?? 0,
                          description: review.description ?? "description",
                          reviewDateTime: review.createdAt ?? DateTime.now(),
                          replies: (review.replies != null &&
                                  review.replies!.isNotEmpty)
                              ? [
                                  for (var reply
                                      in review.replies!["description"])
                                    ReplyOfProvider(
                                      avatarUrl:
                                          reply.user?.avatarImageUrl ?? "",
                                      userName:
                                          reply.user?.fullName ?? "anonymous",
                                      replyText: reply.text ?? "No reply text",
                                      replyDateTime:
                                          reply.createdAt ?? DateTime.now(),
                                    ),
                                ]
                              : [],
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return Text("Error: ${state.error}");
            }
          },
        ),
      ),
    );
  }
}
