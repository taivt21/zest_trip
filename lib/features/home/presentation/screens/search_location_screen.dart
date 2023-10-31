import 'package:flutter/material.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_recommend_location.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                child: const SearchBar(
                  side: MaterialStatePropertyAll(BorderSide(
                      color: primaryColor, style: BorderStyle.solid, width: 2)),
                  surfaceTintColor: MaterialStatePropertyAll(whiteColor),
                  elevation: MaterialStatePropertyAll(0),
                  hintText: "Location...",
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
              Wrap(
                spacing: 12,
                children: [
                  Chip(
                    side: BorderSide.none,
                    backgroundColor: colorLightGrey,
                    padding: const EdgeInsets.all(8),
                    shape: const StadiumBorder(),
                    deleteIcon: const Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    onDeleted: () {},
                    label: const Text('Ha Noi'),
                  ),
                  Chip(
                    side: BorderSide.none,
                    backgroundColor: colorLightGrey,
                    padding: const EdgeInsets.all(8),
                    shape: const StadiumBorder(),
                    label: const Text('Ho Chi Minh'),
                  ),
                  Chip(
                    side: BorderSide.none,
                    backgroundColor: colorLightGrey,
                    padding: const EdgeInsets.all(8),
                    shape: const StadiumBorder(),
                    label: const Text('Da Nang'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Popular locations",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CardRecommendLocation(
                      title: "Da Nang",
                      width: widthScreen * 0.35,
                      imageUrl:
                          'https://emag.archiexpo.com/wp-content/uploads/sites/7/featured-image-2.png',
                      numberOfActivities: 3,
                    ),
                    CardRecommendLocation(
                      title: "Ha Noi",
                      width: widthScreen * 0.35,
                      imageUrl:
                          'https://emag.archiexpo.com/wp-content/uploads/sites/7/featured-image-2.png',
                      numberOfActivities: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
