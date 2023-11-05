import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_tour.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trips",
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TourCard(
              tourName: 'Ben tre',
              imageUrl:
                  'https://mod-movers.com/wp-content/uploads/2020/06/webaliser-_TPTXZd9mOo-unsplash-scaled-e1591134904605.jpg',
              price: '2.500.000.000 ',
            ),
            TourCard(
              tourName: 'Ben tre',
              imageUrl:
                  'https://mod-movers.com/wp-content/uploads/2020/06/webaliser-_TPTXZd9mOo-unsplash-scaled-e1591134904605.jpg',
              price: '2.500.000.000 ',
            ),
            TourCard(
              tourName: 'Ben tre',
              imageUrl:
                  'https://mod-movers.com/wp-content/uploads/2020/06/webaliser-_TPTXZd9mOo-unsplash-scaled-e1591134904605.jpg',
              price: '2.500.000.000 ',
            ),
            // FlutterMap(
            //   mapController: MapController(),
            //   options: const MapOptions(),
            //   children: const [],
            // )
          ],
        ),
      ),
    );
  }
}
