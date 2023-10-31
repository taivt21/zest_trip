import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/search_location_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_item.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_shimmer.dart';
import '../bloc/tour/remote/tour_bloc_ex.dart';

import '../widgets/bottomsheet_filter.dart';
import 'package:logger/logger.dart';

import 'package:zest_trip/get_it.dart';

class SecondaryScreen extends StatefulWidget {
  final TourTag? tag;
  const SecondaryScreen({super.key, this.tag});

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  Set<TourTag> filter = <TourTag>{};
  Set<Widget> shimmerSet = {};
  @override
  Widget build(context) {
    var logger = Logger();

    return MultiBlocProvider(
        providers: [
          BlocProvider<TourTagBloc>(
            create: (context) => sl()..add(const GetTourTags()),
          ),
          BlocProvider<RemoteTourBloc>(
            create: (context) => sl()..add(const GetTours()),
          ),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: _buildAppbar(context),
            body: BlocBuilder<RemoteTourBloc, RemoteTourState>(
              builder: (context, tourState) {
                if (tourState is RemoteTourLoading) {
                  return const TourShimmer();
                }
                if (tourState is RemoteTourDone) {
                  logger.i('render tour item');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: BlocBuilder<TourTagBloc, TourTagState>(
                            builder: (context, tourTagState) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return const FilterBottomSheet();
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorBackground,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.filter_alt_outlined,
                                        color: colorBlack,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        tourTagState.tourTags?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final TourTag tag =
                                          tourTagState.tourTags![index];

                                      String iconName =
                                          tag.name ?? 'default_icon';

                                      String iconAssetPath =
                                          'assets/icons/tags/$iconName.svg';

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: FilterChip(
                                          backgroundColor: whiteColor,
                                          side: BorderSide(
                                            color: filter.contains(tag)
                                                ? primaryColor
                                                : colorBoldGrey!,
                                            width: filter.contains(tag)
                                                ? 1.5
                                                : 1.0,
                                          ),
                                          selectedColor: whiteColor,
                                          showCheckmark: false,
                                          avatar: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: SvgPicture.asset(
                                              iconAssetPath,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                          // selectedColor: fourthColor,
                                          shape: const StadiumBorder(
                                              side: BorderSide(
                                            color: colorPlaceHolder,
                                          )),
                                          label: Text(tag.name ?? ""),
                                          selected: filter.contains(tag),
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                filter.add(tag);
                                              } else {
                                                filter.remove(tag);
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<RemoteTourBloc>()
                                .add(const GetTours());
                          },
                          child: tourState.tours!.isEmpty
                              ? Center(
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
                      ),
                    ],
                  );
                } else if (tourState is RemoteTourError) {
                  return Center(
                    child: Text(
                      'Error loading tours.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                } else {
                  return const SnackBar(content: Text("Fail"));
                }
              },
            ),
            // ),
            // CustomScrollTabBar(
            //   categories: tourTagBloc.state.tourTags ?? [],
            //   onTabChanged: (index) {
            //     // Do something when tab is changed
            //   },
            // ),
          ),
        ));
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                      elevation: const MaterialStatePropertyAll(0.6),
                      hintText: "Search...",
                      controller: controller,
                      // padding: const MaterialStatePropertyAll<EdgeInsets>(
                      //   EdgeInsets.symmetric(horizontal: 8.0),
                      // ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: Chip(
                        padding: const EdgeInsets.all(4),
                        shape: const StadiumBorder(),
                        onDeleted: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchLocationScreen()));
                        },
                        deleteIcon: const Icon(Icons.arrow_drop_down),
                        label: const Text('Location'),
                      ));
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
