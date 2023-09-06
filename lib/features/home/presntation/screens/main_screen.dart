import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import '/config/theme/text_theme.dart';
import '../../presntation/widgets/tour_shimmer.dart';
import '../../../authentication/presentation/blocs/auth_bloc_ex.dart';
import '../bloc/tour/remote/tour_bloc_ex.dart';

import '../widgets/custom_scroll_bar.dart';
import '../widgets/filter_bottomsheet.dart';
import '../widgets/tour_item.dart'; // Import the widget to display each tour item
import 'package:logger/logger.dart';

class MainScreen extends StatefulWidget {
  final TourTag? tag;
  const MainScreen({super.key, this.tag});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return Column(
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthSuccess) {
              // Call the RemoteTourBloc to get the list of tours
              logger.i('load main screen');

              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 3.0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(40),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    border: InputBorder.none,
                                    hintText:
                                        'Where to? \nAnywhere • Any week • Add guests',
                                    hintMaxLines: 2,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Padding(
                                        padding: EdgeInsets.all(16),
                                        child:
                                            FilterBottomSheet()); // Hiển thị form filter trong bottom sheet
                                  },
                                );
                                //// Hiển thị BottomSheet khi nhấn vào biểu tượng "tune"
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.tune,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<TourTagBloc, TourTagState>(
                      builder: (context, tagState) {
                        if (tagState is RemoteTourTagDone) {
                          print('load tour');
                          return SizedBox(
                            height: 58,
                            child: CustomScrollTabBar(
                              categories: tagState.tourTags ?? [],
                              onTabChanged: (index) {
                                // Do something when tab is changed
                              },
                            ),
                          );
                        }
                        // Handle other states if needed
                        return const CircularProgressIndicator(); // Placeholder loading indicator
                      },
                    ),
                    Text('Welcome, ${authState.user.fullName}'),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Error loading user data.'),
              );
            }
          },
        ),
        BlocBuilder<RemoteTourBloc, RemoteTourState>(
          
          builder: (context, tourState) {
            if (tourState is RemoteTourLoading) {
              return const TourShimmer();
            }
            if (tourState is RemoteTourDone) {
              // Display the list of tours
              logger.i('render tour item');

              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // fetch lại danh sách tours
                    context.read<RemoteTourBloc>().add(const GetTours());
                  },
                  child: ListView.builder(
                    itemCount: tourState.tours?.length ?? 0,
                    itemExtent:
                        null, // Set itemExtent to null to remove spacing
                    itemBuilder: (context, index) {
                      final tour = tourState.tours![index];
                      return TourItemWidget(
                          tour:
                              tour); // Create a  widgetto display each tour item
                    },
                  ),
                ),
              );
            } else if (tourState is RemoteTourError) {
              return const Center(
                child: Text(
                  'Error loading tours.',
                  style: AppTextStyles.title,
                ),
              );
            } else {
              return const Center(
                child: Text('Something wrong'),
              );
            }
          },
        ),
      ],
    );
  }
}
