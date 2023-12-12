import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour_manage.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_of_user.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/presentation/bloc/booking/booking_bloc.dart';
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
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            scrolledUnderElevation: 0,
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
              _tabReviewed(context),
              BlocProvider<BookingBloc>(
                create: (context) => sl()..add(const GetBookings()),
                child: RefreshIndicator(onRefresh: () async {
                  final myBookingBloc = BlocProvider.of<BookingBloc>(context);
                  myBookingBloc.add(const GetBookings());
                }, child: BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    if (state is GetBookingSuccess) {
                      List<InvoiceEntity> invoices = state.bookings!;
                      return _buildTabContent(context, invoices, "accepted");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RefreshIndicator _tabReviewed(BuildContext context) {
    return RefreshIndicator(
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
                    subtitle: "Please leave your review for future bookings",
                  )
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
                                    builder: (context) => TourDetailScreen(
                                      tourId: state.reviews[index].tour!.id!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: colorBackground,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 8),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            "${state.reviews[index].tour?.tourImages?.first}",
                                          ),
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
    );
  }
}

Widget _buildTabContent(
    BuildContext context, List<InvoiceEntity> invoices, String status) {
  List<InvoiceEntity> filteredInvoices = invoices
      .where((invoice) =>
          invoice.status?.toLowerCase() == status &&
          !invoice.isReviewed! &&
          invoice.bookedDate!.isBefore(DateTime.now()))
      .toList();

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: const BoxDecoration(color: colorBackground),
    child: filteredInvoices.isEmpty
        ? const EmptyWidget(
            imageSvg: reviewSvg,
            title: "Your feelings are very important",
            subtitle: "Please leave your review for future bookings",
          )
        : ListView.builder(
            itemCount: filteredInvoices.length,
            itemBuilder: (context, index) {
              return CardTourManage(
                invoice: filteredInvoices[index],
              );
            },
          ),
  );
}
