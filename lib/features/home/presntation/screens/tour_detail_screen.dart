import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/presntation/widgets/bottomsheet_booking.dart';

class TourDetailScreen extends StatefulWidget {
  final TourEntity tour;

  const TourDetailScreen({Key? key, required this.tour}) : super(key: key);

  @override
  TourDetailScreenState createState() => TourDetailScreenState();
}

class TourDetailScreenState extends State<TourDetailScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  bool showReadMore = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tour.name ?? "Place details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: whiteColor,
              child: SvgPicture.asset(
                shareSvg,
                height: 20,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: whiteColor,
              child: SvgPicture.asset(
                heartSvg,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: PageView.builder(
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
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor:
                              const Color.fromARGB(255, 116, 112, 112),
                          child: const SizedBox(
                            height: 300,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 51, 51),
                        borderRadius: BorderRadius.circular(8)),
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
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tour.name!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      '${widget.tour.addressCity}, ${widget.tour.addressCountry}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[800], size: 16),
                      const SizedBox(width: 4),
                      Text('4.5 ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.yellow[800],
                                  fontWeight: FontWeight.w400)),
                      RichText(
                        text: const TextSpan(
                          text: '(22+  ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'reviews',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline)),
                            TextSpan(text: ") •")
                          ],
                        ),
                      ),
                      const Text(
                        " 400+ booked",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  Text('${widget.tour.duration} days',
                      style: AppTextStyles.body),
                  const SizedBox(height: 8),
                  Text(
                    'Description:',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.tour.description!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: widget.tour.tags!.map((tag) {
                          return Chip(
                            avatar: const Icon(Icons.location_city_outlined),
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
                      // Chip(
                      //   label: Text(widget.tour.vehicles.map((e) => {})),
                      // ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  const Text(
                    'Schedule:',
                    style: AppTextStyles.headline,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: widget.tour.tourSchedule!.length,
                      itemBuilder: (context, index) {
                        final component = widget.tour.tourSchedule![index];
                        return Expanded(
                          child: TimelineTile(
                            afterLineStyle: const LineStyle(
                              color: Color.fromARGB(255, 245, 238, 238),
                            ),
                            beforeLineStyle: const LineStyle(
                              color: Color.fromARGB(255, 245, 238, 238),
                            ),
                            axis: TimelineAxis.vertical,
                            alignment: TimelineAlign.manual,
                            lineXY: 0,
                            isFirst: index == 0,
                            isLast:
                                index == widget.tour.tourSchedule!.length - 1,
                            indicatorStyle: IndicatorStyle(
                              width: 30,
                              color: const Color.fromARGB(255, 245, 238, 238),
                              iconStyle: IconStyle(
                                iconData: Icons.location_on,
                                color: primaryColor,
                              ),
                            ),
                            endChild: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(component.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(fontSize: 20)),
                                        const SizedBox(height: 8),
                                        Text(
                                          component.description!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 40,
                                      backgroundImage: widget.tour.provider
                                                  ?.avatarImageUrl !=
                                              null
                                          ? NetworkImage(
                                              '${widget.tour.provider?.avatarImageUrl}')
                                          : null),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.tour.provider?.email ?? "Email null",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 18),
                                      SizedBox(width: 4),
                                      Text('4.5', style: AppTextStyles.body),
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
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 8,
            right: 8,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("From"),
                    Text(
                      '₫ ${widget.tour.price},000',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    // Text(
                    //   '/person',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodySmall
                    //       ?.copyWith(fontWeight: FontWeight.w300),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: ElevatedButtonCustom(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      context: context,
                      builder: (context) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            padding: const EdgeInsets.all(16),
                            child: const BookingBottomSheet());
                      },
                    );
                  },
                  text: tCheckAvailable,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
