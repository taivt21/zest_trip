import 'package:flutter/material.dart';
import 'package:zest_trip/features/home/presntation/widgets/destination.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wishlist',
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
        ),
        body: ListView(
          children: const [
            ForYouDestinationWidget(),
          ],
        ));
  }
}
