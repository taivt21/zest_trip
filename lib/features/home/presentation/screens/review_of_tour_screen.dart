import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/get_it.dart';

class ReviewsOfTour extends StatefulWidget {
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
  State<ReviewsOfTour> createState() => _ReviewsOfTourState();
}

class _ReviewsOfTourState extends State<ReviewsOfTour> {
  @override
  void dispose() {
    super.dispose();
  }

  int? selectedStars;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TourReviewsBloc>(
      create: (context) => sl()..add(GetTourReviews(widget.tourId)),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(num.parse(widget.ratingTour).toStringAsFixed(1),
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
                                num starValue = num.parse(widget.ratingTour);
                                num remainder = starValue - index;

                                if (remainder >= 1) {
                                  return const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else if (remainder > 0.5) {
                                  return const Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else if (remainder > 0) {
                                  return const Icon(
                                    Icons.star_half_rounded,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.star_border_rounded,
                                    color: Colors.amber,
                                    size: 32.0,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text("${widget.ratingCount} Reviews",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<int>(
                                icon: const Icon(Icons.filter_list),
                                itemBuilder: (context) {
                                  List<PopupMenuItem<int>> items = [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("Show all"),
                                    ),
                                  ];

                                  items.addAll(List.generate(5, (index) {
                                    return PopupMenuItem<int>(
                                      value: index + 1,
                                      child: Row(
                                        children: [
                                          Text('${index + 1}'),
                                          const Icon(Icons.star_rounded,
                                              color: Colors.amber),
                                        ],
                                      ),
                                    );
                                  }));

                                  return items;
                                },
                                onSelected: (int? value) {
                                  setState(() {
                                    selectedStars = value == 0 ? null : value;
                                  });
                                },
                              ),
                              if (selectedStars != null)
                                Row(
                                  children: [
                                    Text('$selectedStars'),
                                    const Icon(Icons.star_rounded,
                                        color: Colors.amber),
                                  ],
                                )
                              else
                                const Text("Filter"),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: selectedStars != null
                              ? state.reviews!
                                  .where((review) =>
                                      review.rating == selectedStars)
                                  .length
                              : state.reviews!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var review = selectedStars != null
                                ? state.reviews!
                                    .where((review) =>
                                        review.rating == selectedStars)
                                    .toList()[index]
                                : state.reviews![index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: UserReview(tourReview: review),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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
