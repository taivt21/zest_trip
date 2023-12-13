// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/district/district_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/search_location_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/search_query_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_item.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_shimmer.dart';
import 'package:zest_trip/get_it.dart';

import '../blocs/tour/remote/tour_bloc_ex.dart';
import '../widgets/bottomsheet_filter.dart';

class SecondaryScreen extends StatefulWidget {
  final TourTag? tag;
  final String? searchLocation;

  const SecondaryScreen({
    Key? key,
    this.tag,
    this.searchLocation,
  }) : super(key: key);

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  final ScrollController _scrollController = ScrollController();
  late int currentPage;
  late bool _isLoading;
  String search = "";
  String province = "";
  String district = "";
  Set<int> tagIds = <int>{};
  Set<int> vehicleIds = <int>{};
  int limit = 5;
  int? fromPrice = -1;
  int? toPrice = -1;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    province = widget.searchLocation ?? "";
    currentPage = 1;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourWishlistBloc>(
          create: (context) => sl()..add(const GetWishlist()),
        ),
        BlocProvider<DistrictBloc>(
          create: (context) => sl()..add(const GetDistricts()),
        ),
        BlocProvider<ProvinceBloc>(
          create: (context) => sl()..add(const GetProvinces()),
        ),
        BlocProvider<RemoteTourBloc>(
          create: (context) => sl()
            ..add(GetTours(
              page: 1,
              limit: limit,
              tags: tagIds,
              search: search,
              province: province,
              district: district,
              lowPrice: fromPrice,
              highPrice: toPrice,
            )),
        ),
        BlocProvider<TourTagBloc>(
          create: (context) => sl()..add(const GetTourTags()),
        ),
        BlocProvider<TourVehicleBloc>(
          create: (context) => sl()..add(const GetTourVehicles()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
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
                            hintText:
                                search.isEmpty ? "Search tour..." : search,
                            controller: controller,
                            onTap: () async {
                              final searchQuery = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchQueryScreen(),
                                ),
                              );

                              if (searchQuery != null) {
                                setState(() {
                                  search = searchQuery;
                                });
                                if (mounted) {
                                  final remoteTourBloc =
                                      BlocProvider.of<RemoteTourBloc>(context);
                                  remoteTourBloc.add(const ClearTour());
                                  remoteTourBloc.add(GetTours(
                                    page: currentPage,
                                    limit: limit,
                                    tags: tagIds,
                                    search: search,
                                    province: province,
                                    district: district,
                                  ));
                                }
                              }
                            },
                            trailing: [
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    currentPage = 1;
                                    tagIds = {};
                                    vehicleIds = {};
                                    province = "";
                                    district = "";
                                    search = "";
                                  });
                                  final remoteTourBloc =
                                      BlocProvider.of<RemoteTourBloc>(context);
                                  remoteTourBloc.add(const ClearTour());
                                  remoteTourBloc.add(GetTours(
                                    page: currentPage,
                                    limit: limit,
                                    tags: tagIds,
                                    search: search,
                                    province: province,
                                    district: district,
                                  ));
                                },
                              ),
                            ],
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
                                    province = selectedLocation;
                                  });
                                  if (mounted) {
                                    final remoteTourBloc =
                                        BlocProvider.of<RemoteTourBloc>(
                                            context);
                                    remoteTourBloc.add(const ClearTour());
                                    remoteTourBloc.add(GetTours(
                                      page: currentPage,
                                      limit: limit,
                                      tags: tagIds,
                                      search: search,
                                      province: province,
                                      district: district,
                                    ));
                                  }
                                }
                              },
                              child: Chip(
                                padding: const EdgeInsets.all(4),
                                shape: const StadiumBorder(),
                                label: Row(
                                  children: [
                                    Text(
                                        province == "" ? "Location" : province),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
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
                            search = "";
                            province = "";
                            district = "";
                            _isLoading = true;
                          });
                          remoteTourBloc.add(
                            GetTours(
                              page: currentPage,
                              limit: limit,
                              tags: tagIds,
                              search: search,
                              province: province,
                              district: district,
                            ),
                          );
                        },
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo is ScrollEndNotification &&
                                _scrollController.position.extentAfter == 0) {
                              setState(() {
                                currentPage++;
                              });

                              BlocProvider.of<RemoteTourBloc>(context).add(
                                GetTours(
                                  page: currentPage,
                                  limit: limit,
                                  tags: tagIds,
                                  search: search,
                                  province: province,
                                  district: district,
                                  lowPrice: fromPrice,
                                  highPrice: toPrice,
                                ),
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
                                    imageSvg: travelSvg,
                                    title: "No tour found",
                                    subtitle:
                                        "Please try searching for other keywords",
                                  ),
                                  // child: CircularProgressIndicator(),
                                );
                              } else if (index < tourState.tours!.length) {
                                final tour = tourState.tours![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TourDetailScreen(
                                          tourId: tour.id!,
                                        ),
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
                  content:
                      Text("${tourState.error?.response?.data['message']}"),
                );
              }
            },
          ),
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
            return BlocBuilder<TourVehicleBloc, TourVehicleState>(
              builder: (context, tourVehicleState) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        Map<String, dynamic>? result =
                            await showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: FilterBottomSheet(
                                listTags: tourTagState.tourTags ?? [],
                                listVehicle:
                                    tourVehicleState.tourVehicles ?? [],
                                province: province,
                                district: district,
                                tagIds: tagIds,
                                vehicleIds: vehicleIds,
                                fromPrice: fromPrice,
                                toPrice: toPrice,
                              ),
                            );
                          },
                        );

                        if (result != null) {
                          setState(() {
                            tagIds = Set.from(result['selectedTags']);
                            vehicleIds = Set.from(result['selectedVehicles']);
                            province = result['selectedProvince'];
                            district = result['selectedDistrict'];
                            fromPrice = result['selectedFrom'];
                            toPrice = result['selectedTo'];
                          });
                          if (mounted) {
                            final remoteTourBloc =
                                BlocProvider.of<RemoteTourBloc>(context);
                            remoteTourBloc.add(const ClearTour());
                            remoteTourBloc.add(
                              GetTours(
                                page: 1,
                                limit: limit,
                                tags: tagIds,
                                search: search,
                                province: province,
                                district: district,
                                lowPrice: fromPrice,
                                highPrice: toPrice,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_alt_outlined,
                              color: colorBlack,
                            ),
                            Text(
                                "•${totalFilters(tagIds, vehicleIds, province, district)}")
                          ],
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

                        String iconAssetPath =
                            'assets/icons/tags/$iconName.svg';

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
                                  currentPage = 1;
                                  tagIds.add(tagId);
                                  remoteTourBloc.add(
                                    const ClearTour(),
                                  );
                                  remoteTourBloc.add(
                                    GetTours(
                                      page: currentPage,
                                      limit: limit,
                                      tags: tagIds,
                                      search: search,
                                      province: province,
                                      district: district,
                                    ),
                                  );
                                } else {
                                  currentPage = 1;
                                  tagIds.remove(tagId);
                                  remoteTourBloc.add(
                                    const ClearTour(),
                                  );
                                  remoteTourBloc.add(
                                    GetTours(
                                      page: currentPage,
                                      limit: limit,
                                      tags: tagIds,
                                      search: search,
                                      province: province,
                                      district: district,
                                    ),
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
            );
          },
        ),
      ),
    );
  }

  int totalFilters(
    Set<int> listTag,
    Set<int> listVehicle,
    String? province,
    String? district,
  ) {
    int total = 0;
    int tag = listTag.length;
    int vehicle = listVehicle.length;
    if (province != "") {
      total += 1;
    }
    if (district != "") {
      total += 1;
    }
    if (fromPrice != -1 && toPrice != -1) {
      total += 1;
    }
    return total + tag + vehicle;
  }
}
