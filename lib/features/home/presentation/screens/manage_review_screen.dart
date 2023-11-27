import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';

class ManageReviewScreen extends StatelessWidget {
  const ManageReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Review"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Reviewed'),
              Tab(text: 'Not Reviewed Yet'),
            ],
          ),
        ),
        body: BlocBuilder<MyReviewBloc, MyReviewState>(
          builder: (context, state) {
            if (state is GetReviewSuccess) {
              return TabBarView(
                children: [
                  // Tab for "Reviewed"
                  state.reviews.isEmpty
                      ? const EmptyWidget(
                          imageSvg: reviewSvg,
                          title: "Your feelings are very important",
                          subtitle:
                              "Please leave your review for future bookings")
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: colorHint,
                          ),
                          itemCount: state.reviews.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                children: [
                                  UserReview(
                                    tourReview: state.reviews[index],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TourDetailScreen(
                                                  tour: state
                                                      .reviews[index].tour!),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: colorBackground,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: CachedNetworkImageProvider(
                                                    "${state.reviews[index].tour?.tourImages?.first}"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "${state.reviews[index].tour?.name}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                  // Tab for "Not Reviewed Yet"
                  const EmptyWidget(
                      imageSvg: reviewSvg,
                      title: "Your feelings are very important",
                      subtitle: "Please leave your review for future bookings")
                ],
              );
            } else if (state is GetReviewFail) {
              return const Text("Get my review fail");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
