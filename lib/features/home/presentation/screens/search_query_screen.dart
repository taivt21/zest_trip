import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
