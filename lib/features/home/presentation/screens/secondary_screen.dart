import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/search_location_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_item.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_shimmer.dart';
import '../blocs/tour/remote/tour_bloc_ex.dart';

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
  final ScrollController _scrollController = ScrollController();
  late int currentPage;
  bool _isLoading = true;
  String search = "";
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    currentPage = 1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Set<int> tagIds = <int>{};

  @override
  Widget build(context) {
    var logger = Logger();

    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteTourBloc>(
          create: (context) => sl()
            ..add(GetTours(page: 1, limit: 5, tags: tagIds, search: search)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
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
                    builder:
                        (BuildContext context, SearchController controller) {
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
                          leading: GestureDetector(
                            onTap: () async {
                              final selectedLocation = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchLocationScreen(),
                                ),
                              );

                              if (selectedLocation != null) {
                                setState(() {
                                  search = selectedLocation;
                                });
                                final remoteTourBloc =
                                    BlocProvider.of<RemoteTourBloc>(context);
                                remoteTourBloc.add(const ClearTour());
                                remoteTourBloc.add(GetTours(
                                  page: currentPage,
                                  limit: 5,
                                  tags: tagIds,
                                  search: search,
                                ));
                              }
                            },
                            child: Chip(
                              padding: const EdgeInsets.all(4),
                              shape: const StadiumBorder(),
                              deleteIcon: const Icon(Icons.arrow_drop_down),
                              label: Text(search == "" ? "Location" : search),
                            ),
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
        ),
        body: BlocBuilder<RemoteTourBloc, RemoteTourState>(
          buildWhen: (previous, current) => previous.tours != current.tours,
          builder: (context, tourState) {
            if (tourState is RemoteTourLoading) {
              return const TourShimmer();
            }
            if (tourState is RemoteTourDone) {
              logger.i('tour state-------------: ${tourState.tours?.length}');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTag(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        final remoteTourBloc =
                            BlocProvider.of<RemoteTourBloc>(context);
                        remoteTourBloc.add(const ClearTour());
                        setState(() {
                          currentPage = 1;
                          tagIds = {};
                          _isLoading = true;
                        });
                        remoteTourBloc.add(
                          GetTours(
                              page: currentPage,
                              limit: 5,
                              tags: tagIds,
                              search: search),
                        );
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo is ScrollEndNotification &&
                              _scrollController.position.extentAfter == 0) {
                            setState(() {
                              currentPage++;
                              debugPrint("current page: $currentPage");
                            });

                            BlocProvider.of<RemoteTourBloc>(context).add(
                              GetTours(
                                  page: currentPage, limit: 5, tags: tagIds),
                            );
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: tourState.tours!.isEmpty
                              ? 1
                              : tourState.tours!.length +
                                  (tourState.hasMore! ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (tourState.tours!.isEmpty) {
                              return const Center(
                                child: EmptyWidget(
                                  imageSvg: logoNoLetter,
                                  title: "Don't have any tour",
                                  subtitle: "",
                                ),
                                // child: CircularProgressIndicator(),
                              );
                            } else if (index < tourState.tours!.length) {
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
                            } else {
                              return Center(
                                child: _isLoading
                                    ? const CircularProgressIndicator()
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: const Text("No more to load")),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (tourState is RemoteTourError) {
              return Center(
                child: Text(
                  '${tourState.error?.response?.data['message']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            } else {
              return SnackBar(
                content: Text("${tourState.error?.response?.data['message']}"),
              );
            }
          },
        ),
      ),
    );
  }

  Container _buildTag() {
    return Container(
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
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
                  itemCount: tourTagState.tourTags?.length ?? 0,
                  itemBuilder: (context, index) {
                    final TourTag tag = tourTagState.tourTags![index];
                    final int tagId = tag.id!;
                    String iconName = tag.name ?? 'default_icon';

                    String iconAssetPath = 'assets/icons/tags/$iconName.svg';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        backgroundColor: whiteColor,
                        side: BorderSide(
                          color: tagIds.contains(tagId)
                              ? primaryColor
                              : colorBoldGrey!,
                          width: tagIds.contains(tagId) ? 2.5 : 1.0,
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
                        selected: tagIds.contains(tagId),
                        onSelected: (bool selected) {
                          final remoteTourBloc =
                              BlocProvider.of<RemoteTourBloc>(context);
                          setState(() {
                            if (selected) {
                              tagIds.add(tagId);
                              remoteTourBloc.add(
                                const ClearTour(),
                              );
                              remoteTourBloc.add(
                                GetTours(
                                    page: 1,
                                    limit: 5,
                                    tags: tagIds,
                                    search: search),
                              );

                              print("tagId : $tagIds");
                            } else {
                              tagIds.remove(tagId);
                              remoteTourBloc.add(
                                const ClearTour(),
                              );
                              remoteTourBloc.add(
                                GetTours(
                                    page: 1,
                                    limit: 5,
                                    tags: tagIds,
                                    search: search),
                              );
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
    );
  }
}
