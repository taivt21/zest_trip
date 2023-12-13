import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_search/tour_recommend_search_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/province/province_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_recommend_location.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zest_trip/get_it.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> allLocationNames = []; // Danh sách provinces

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProvinceBloc>(
            create: (context) => sl()..add(const GetProvinces()),
          ),
          BlocProvider<LocationPopularBloc>(
            create: (context) => sl()..add(const GetPopularLocation()),
          ),
          BlocProvider<TourRecommendSearchBloc>(
            create: (context) => sl()..add(const GetToursRcmSearch()),
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(32)),
                  height: MediaQuery.of(context).size.height * 0.5,
                  margin: const EdgeInsets.only(top: 8, right: 16),
                  child: BlocBuilder<ProvinceBloc, ProvinceState>(
                    builder: (context, state) {
                      allLocationNames = state.provinces
                              ?.map((province) => province.name ?? "")
                              .toList() ??
                          [];
                      return TypeAheadField<String>(
                        noItemsFoundBuilder: (context) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No province matches',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          // autofocus: true,
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: "Province...",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return allLocationNames.where((name) => name
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            searchController.text = suggestion;
                          });
                          Navigator.pop(context, suggestion);
                        },
                        loadingBuilder: (context) => const Text('Loading...'),
                        errorBuilder: (context, error) => const Text('Error!'),
                      );
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
        ),
      ),
    );
  }
}
