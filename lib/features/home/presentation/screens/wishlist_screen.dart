import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presentation/widgets/item_booking.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My wishlist'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return ItemBooking(
              width: double.infinity,
              imageUrl:
                  'https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg',
              title: 'Location Title $index',
              price: 200,
              numberOfActivities: 5,
            );
          },
        ),
      ),
    );
  }
}
