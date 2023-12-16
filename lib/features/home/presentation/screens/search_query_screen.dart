import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tag_popular/tag_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_search/tour_recommend_search_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_recommend_location.dart';
import 'package:zest_trip/get_it.dart';

class SearchQueryScreen extends StatefulWidget {
  const SearchQueryScreen({super.key});

  @override
  State<SearchQueryScreen> createState() => _SearchQueryScreenState();
}

class _SearchQueryScreenState extends State<SearchQueryScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocationPopularBloc>(
            create: (context) => sl()..add(const GetPopularLocation()),
          ),
          BlocProvider<TagPopularBloc>(
            create: (context) => sl()..add(const GetPopularTag()),
          ),
          BlocProvider<TourRecommendSearchBloc>(
            create: (context) => sl()..add(const GetToursRcmSearch()),
          ),
          BlocProvider<TourTagBloc>(
            create: (context) => sl()..add(const GetTourTags()),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Row(children: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: SearchBar(
                    side: const MaterialStatePropertyAll(BorderSide(
                        color: primaryColor,
                        style: BorderStyle.solid,
                        width: 2)),
                    surfaceTintColor:
                        const MaterialStatePropertyAll(whiteColor),
                    elevation: const MaterialStatePropertyAll(0),
                    hintText: "Search...",
                    trailing: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context, searchController.text);
                          },
                          child: const Icon(Icons.search, color: primaryColor)),
                    ],
                    onChanged: (value) {
                      setState(() {
                        searchController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ]),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular tag",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BlocBuilder<TourTagBloc, TourTagState>(
                    builder: (context, tourTagState) {
                      if (tourTagState is RemoteTourTagDone) {
                        return BlocBuilder<TagPopularBloc, TagPopularState>(
                          builder: (context, tagsState) {
                            List<dynamic> tags = tagsState.tags ?? [];
                            List<int> highlightedIds = tags
                                .map((dynamic value) => value as int)
                                .toList();
                            return _buildSelectedTags(
                                highlightedIds, tourTagState.tourTags!);
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Text(
                    "Popular location",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BlocBuilder<LocationPopularBloc, LocationPopularState>(
                    builder: (context, state) {
                      return Wrap(
                        spacing: 12,
                        children: (state.locations ?? []).map((location) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context, location);
                            },
                            child: Chip(
                              padding: const EdgeInsets.all(8),
                              shape: const StadiumBorder(),
                              label: Text(location),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Tours are highly sought after",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<TourRecommendSearchBloc,
                      TourRecommendSearchState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            state.tours?.length ?? 0,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TourDetailScreen(
                                      tourId: state.tours![index].id!,
                                    ),
                                  ),
                                );
                              },
                              child: CardRecommendLocation(
                                tour: state.tours![index],
                                width: MediaQuery.of(context).size.width * 0.35,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Wrap _buildSelectedTags(List<int> selectedTagIds, List<TourTag> allTags) {
    List<TourTag> selectedTags =
        allTags.where((tag) => selectedTagIds.contains(tag.id)).toList();

    return Wrap(
      spacing: 12,
      children: selectedTags.map((tag) {
        String iconName = tag.name ?? 'default_icon';
        String iconAssetPath = 'assets/icons/tags/$iconName.svg';

        return Chip(
          padding: const EdgeInsets.all(4),
          shape: const StadiumBorder(),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconAssetPath,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 4),
              Text(tag.name ?? ""),
            ],
          ),
        );
      }).toList(),
    );
  }
}
