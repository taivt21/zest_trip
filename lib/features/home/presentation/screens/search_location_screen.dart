import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_search/tour_recommend_search_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_recommend_location.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(scrolledUnderElevation: 0,
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
                      color: primaryColor, style: BorderStyle.solid, width: 2)),
                  surfaceTintColor: const MaterialStatePropertyAll(whiteColor),
                  elevation: const MaterialStatePropertyAll(0),
                  hintText: "Location...",
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              BlocBuilder<TourRecommendSearchBloc, TourRecommendSearchState>(
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
                            width: widthScreen * 0.35,
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
    );
  }
}
