import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';
import 'package:zest_trip/features/payment/presentation/widgets/card_review_of_user.dart';

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
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: colorBackground,
                    child: state.reviews.isEmpty
                        ? const EmptyWidget(
                            imageSvg: reviewSvg,
                            title: "Your feelings are very important",
                            subtitle:
                                "Please leave your review for future bookings")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.reviews.length,
                            itemBuilder: (context, index) {
                              return CardReviewOfUser(
                                review: state.reviews[index],
                              );
                            },
                          ),
                  ),
                  // Tab for "Not Reviewed Yet"
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: colorBackground,
                    child: const Text("Page not reviewed yet"),
                  ),
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
