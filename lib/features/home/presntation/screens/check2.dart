import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

class TourDetailScreen extends StatefulWidget {
  final TourEntity tour;

  const TourDetailScreen({Key? key, required this.tour}) : super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.tour.tourImages!.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.tour.tourImages![index],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            top: 50,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 51, 51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_currentPage + 1}/${widget.tour.tourImages!.length}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.black),
                title: Text(
                  widget.tour.name!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    transform: Matrix4.translationValues(0.0, -100.0, 0.0), // Adjust the value as needed
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.tour.name!,
                              style: AppTextStyles.title,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.star, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  '4.5', // Replace with actual rating
                                  style: AppTextStyles.headline,
                                ),
                              ],
                            ),
                          ],
                        ),
                      Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.tour.name!,
                                style: AppTextStyles.title,
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.star, size: 20),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.5', // Replace with actual rating
                                    style: AppTextStyles.headline,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${widget.tour.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('${widget.tour.durationDay} days',
                              style: AppTextStyles.body),
                          const SizedBox(height: 8),
                          const Text(
                            'Description:',
                            style: AppTextStyles.headline,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.tour.description!,
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTourComponentIcon(
                                  Icons.restaurant, 'Meals'),
                              _buildTourComponentIcon(
                                  Icons.hotel, 'Accommodation'),
                              _buildTourComponentIcon(
                                  Icons.directions_bus, 'Transportation'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              Wrap(
                                spacing: 8,
                                children: widget.tour.tags!.map((tag) {
                                  return Chip(
                                    avatar: const Icon(
                                        Icons.location_city_outlined),
                                    label: Text(tag.name.toString()),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Vehicles:',
                                style: AppTextStyles.headline,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),

                          const SizedBox(height: 8),
                          const Text(
                            'Schedule:',
                            style: AppTextStyles.headline,
                          ),
                          Column(
                            children:
                                widget.tour.tourComponents!.map((component) {
                              return ListTile(
                                title: Text(component.title!,
                                    style: AppTextStyles.headline),
                                subtitle: Text(
                                  component.description!,
                                  style: AppTextStyles.body,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 8),

                          // Display host information
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                          builder: (context, state) {
                                        if (state is AuthSuccess) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                    '${state.user.avatarImageUrl}'),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${state.user.email}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                                    ),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star, size: 18),
                                              SizedBox(width: 4),
                                              Text('4.5',
                                                  style: AppTextStyles.body),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text('123 Reviews',
                                              style: AppTextStyles.body),
                                          SizedBox(height: 4),
                                          Text('Joined 2 years ago',
                                              style: AppTextStyles.body),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Display user reviews
                          const ListTile(
                            title: Text(
                              'User Reviews',
                              style: AppTextStyles.headline,
                            ),
                            subtitle: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Great Experience',
                                    style: AppTextStyles.body,
                                  ),
                                  subtitle: Text(
                                    'Rating: 4.5',
                                    style: AppTextStyles.body,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    'Highly Recommend',
                                    style: AppTextStyles.body,
                                  ),
                                  subtitle: Text(
                                    'Rating: 5.0',
                                    style: AppTextStyles.body,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _buildTourComponentIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}