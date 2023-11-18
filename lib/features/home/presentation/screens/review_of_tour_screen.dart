import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/get_it.dart';

class ReviewsOfTour extends StatelessWidget {
  final String tourId;
  final String ratingTour;
  final int ratingCount;
  const ReviewsOfTour({
    super.key,
    required this.tourId,
    required this.ratingTour,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TourReviewsBloc>(
      create: (context) => sl()..add(GetTourReviews(tourId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All reviews"),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: Divider(
              color: Colors.black,
            ),
          ),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(num.parse(ratingTour).toStringAsFixed(1),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          Text(" /5",
                              style: Theme.of(context).textTheme.bodyMedium),

                          const SizedBox(width: 8.0),

                          Row(
                            children: List.generate(
                              5,
                              (index) {
                                num starValue = num.parse(ratingTour);
                                num remainder = starValue - index;

                                if (remainder >= 1) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else if (remainder > 0.5) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else if (remainder > 0) {
                                  return const Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                }
                              },
                            ),
                          ),

                          const SizedBox(width: 8.0),

                          // Reviews count text
                          Text("$ratingCount Reviews",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      for (var review in state.reviews!)
                        UserReview(tourReview: review),
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
