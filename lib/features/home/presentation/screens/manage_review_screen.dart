import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';
import 'package:zest_trip/get_it.dart';

class ManageReviewScreen extends StatelessWidget {
  const ManageReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyReviewBloc>(
      create: (context) => sl()..add(GetMyReview()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(scrolledUnderElevation: 0,
            title: const Text("My Review"),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Reviewed'),
                Tab(text: 'Not Reviewed Yet'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<MyReviewBloc>(context).add(GetMyReview());
                },
                child: BlocBuilder<MyReviewBloc, MyReviewState>(
                builder: (context, state) {
                    if (state is GetReviewSuccess) {
                      return state.reviews.isEmpty
                          ? const EmptyWidget(
                              imageSvg: reviewSvg,
                              title: "Your feelings are very important",
                              subtitle:
                                  "Please leave your review for future bookings",
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: colorHint,
                              ),
                              itemCount: state.reviews.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                                                tourId: state
                                                    .reviews[index].tour!.id!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          color: colorBackground,
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      "${state.reviews[index].tour?.tourImages?.first}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "${state.reviews[index].tour?.name}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
              RefreshIndicator(
                onRefresh: () async {
                  final myReviewBloc = BlocProvider.of<MyReviewBloc>(context);
                  myReviewBloc.add(GetMyReview()); // Adjust the event as needed
                },
                child: Builder(
                  builder: (context) {
                    final state = BlocProvider.of<MyReviewBloc>(context).state;
                    return state is GetReviewSuccess
                        ? const EmptyWidget(
                            imageSvg: reviewSvg,
                            title: "Your feelings are very important",
                            subtitle:
                                "Please leave your review for future bookings",
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
