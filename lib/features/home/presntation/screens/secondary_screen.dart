import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presntation/screens/tour_detail_screen.dart';
import '../bloc/tour/remote/tour_bloc_ex.dart';

import '../widgets/custom_scroll_bar.dart';
import '../widgets/bottomsheet_filter.dart';
import '../widgets/tour_item.dart';
import 'package:logger/logger.dart';

class SecondaryScreen extends StatefulWidget {
  final TourTag? tag;
  const SecondaryScreen({super.key, this.tag});

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  @override
  Widget build(context) {
    var logger = Logger();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 3.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              hintText:
                                  'Where to? \nAnywhere • Any week • Add guests',
                              hintMaxLines: 2,
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16))),
                            context: context,
                            builder: (context) {
                              return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child:
                                      FilterBottomSheet()); // Hiển thị form filter trong bottom sheet
                            },
                          );
                          //// Hiển thị BottomSheet khi nhấn vào biểu tượng "tune"
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.tune,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomScrollTabBar(
                categories: context.watch<TourTagBloc>().state.tourTags ?? [],
                onTabChanged: (index) {
                  // Do something when tab is changed
                },
              ),
            ],
          ),
        ),
        BlocBuilder<RemoteTourBloc, RemoteTourState>(
          builder: (context, tourState) {
            // if (tourState is RemoteTourLoading) {
            //   return const TourShimmer();
            // }
            if (tourState is RemoteTourDone) {
              logger.i('render tour item');

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<RemoteTourBloc>().add(const GetTours());
                  },
                  child: tourState.tours!.isEmpty
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Không có tour nào"),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {
                                  context
                                      .read<RemoteTourBloc>()
                                      .add(const GetTours());
                                },
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          // separatorBuilder: (context, index) => const Divider(),
                          itemCount: tourState.tours!.length,
                          itemBuilder: (context, index) {
                            final tour = tourState.tours![index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TourDetailScreen(tour: tour),
                                  ),
                                );
                              },
                              child: TourItemWidget(tour: tour),
                            );
                          },
                        ),
                ),
              );
            } else if (tourState is RemoteTourError) {
              return Center(
                child: Text(
                  'Error loading tours.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
            if (tourState is AddedToWishlist) {
              return const SnackBar(content: Text("Added to wishlist"));
            } else {
              return const Center(
                child: Text('Something wrong'),
              );
            }
          },
        ),
      ],
    );
  }
}
