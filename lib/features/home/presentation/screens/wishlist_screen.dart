import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate some dummy data
    final List<TourEntity> tours = [
      const TourEntity(
        id: '1',
        name: 'Tour 1',
        description: 'Description of Tour 1',
        tourImages: ['image_url_1'],
        price: 100.0,
        duration: 2,
      ),
      const TourEntity(
        id: '2',
        name: 'Tour 2',
        description: 'Description of Tour 2',
        tourImages: ['image_url_2'],
        price: 150.0,
        duration: 3,
      ),
      // Add more dummy data as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return _buildTourItem(tours[index]);
        },
      ),
    );
  }

  Widget _buildTourItem(TourEntity tour) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            tour.tourImages?.first ?? '',
            height: 120.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  tour.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Price: \$${tour.price ?? 0.0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Duration: ${tour.duration ?? 0} hours',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
