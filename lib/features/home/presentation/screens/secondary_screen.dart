import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
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
  bool isLoadingMore = false;
  // final _controller = TextEditingController();
  // var uuid = const Uuid();
  // final String _sessionToken = '1234567890';
  // List<dynamic> _placeList = [];

  // void getSuggestion(String input) async {
  //   String kplacesApiKey = "AIzaSyDRohqsJ3uY_bpfD9VGClxbXHp73_dhgq0";
  //   String type = '(regions)';

  //   try {
  //     String baseURL =
  //         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //     String request =
  //         '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';

  //     Response response = await Dio().get(request);

  //     var data = response.data;
  //     print('mydata');
  //     print(data);

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _placeList = response.data['predictions'];
  //       });
  //     } else {
  //       throw Exception('Failed to load predictions');
  //     }
  //   } catch (e) {
  //     // Xử lý ngoại lệ
  //     // toastMessage('success');
  //   }
  // }

  @override
  void initState() {
    currentPage = 1;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Set<TourTag> filter = <TourTag>{};
  List<TourEntity> allTours = [];

  @override
  Widget build(context) {
    var logger = Logger();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TourTagBloc>(
          create: (context) => sl()..add(const GetTourTags()),
        ),
        BlocProvider<RemoteTourBloc>(
          create: (context) => sl()..add(const GetTours(page: 1, limit: 5)),
        ),
      ],
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: BlocBuilder<RemoteTourBloc, RemoteTourState>(
          builder: (context, tourState) {
            if (tourState is RemoteTourLoading) {
              return const TourShimmer();
            }
            if (tourState is RemoteTourDone) {
              logger.i('tour state: $tourState');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTag(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          currentPage = 1;
                        });
                        // dispose();
                        BlocProvider.of<RemoteTourBloc>(context).add(
                          GetTours(page: currentPage, limit: 5),
                        );
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo is ScrollEndNotification &&
                              _scrollController.position.extentAfter == 0) {
                            setState(() {
                              isLoadingMore = true;
                              currentPage++;
                              debugPrint("current page: $currentPage");
                            });

                            BlocProvider.of<RemoteTourBloc>(context).add(
                              GetTours(page: currentPage, limit: 5),
                            );
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: tourState.tours.isEmpty
                              ? 1 // Nếu danh sách rỗng, hiển thị một lần cho EmptyWidget
                              : tourState.tours.length + 1,
                          itemBuilder: (context, index) {
                            if (tourState.tours.isEmpty) {
                              // Hiển thị EmptyWidget nếu danh sách rỗng
                              return const Center(
                                child: EmptyWidget(
                                  imageSvg: logoNoLetter,
                                  title: "Don't have any tour",
                                  subtitle: "",
                                ),
                              );
                            } else if (index < tourState.tours.length) {
                              final tour = tourState.tours[index];
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
                                child: isLoadingMore
                                    ? const CircularProgressIndicator()
                                    : const SizedBox.shrink(),
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

                    String iconName = tag.name ?? 'default_icon';

                    String iconAssetPath = 'assets/icons/tags/$iconName.svg';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        backgroundColor: whiteColor,
                        side: BorderSide(
                          color: filter.contains(tag)
                              ? primaryColor
                              : colorBoldGrey!,
                          width: filter.contains(tag) ? 2.5 : 1.0,
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
    );
  }

  // ),
  // CustomScrollTabBar(
  //   categories: tourTagBloc.state.tourTags ?? [],
  //   onTabChanged: (index) {
  //     // Do something when tab is changed
  //   },
  // ),
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
