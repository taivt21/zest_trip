import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/theme/text_theme.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_detail_widget.dart';
import 'package:zest_trip/features/payment/presentation/widgets/bottomsheet_booking.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';

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
  int rating = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleDetail = [
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
      Text('${widget.tour.addressCity}, ${widget.tour.addressCountry}',
          style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(
        height: 4,
      ),
      Row(
        children: [
          Icon(Icons.star, color: Colors.yellow[800], size: 16),
          const SizedBox(width: 4),
          Text('${widget.tour.avgRating} ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.yellow[800], fontWeight: FontWeight.w400)),
          RichText(
            text: TextSpan(
              text: '(${widget.tour.count?['TourReview']}  ',
              style: const TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.black),
              children: const <TextSpan>[
                TextSpan(
                    text: 'reviews',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.underline)),
                TextSpan(text: ") • ")
              ],
            ),
          ),
          Text(
            "${widget.tour.count?['TourReview']} booked",
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),

      const SizedBox(height: 4),
      Text('${widget.tour.duration} days', style: AppTextStyles.body),
      const SizedBox(height: 8),
      const Titles(title: "About"),
      const SizedBox(height: 8),
      Text(
        widget.tour.description!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
      ),
      const SizedBox(height: 16),

      Wrap(
        spacing: 8,
        children: _buildChips(widget.tour.tags, "tags"),
      ),
      const SizedBox(height: 8),
      const Titles(
        title: "Vehicles",
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: _buildChips(widget.tour.vehicles, "vehicles"),
      ),
      const SizedBox(height: 8),

      // ExpansionTile(
      //   tilePadding: const EdgeInsets.all(0),
      //   title: const Titles(title: "Schedules"),
      //   children: [
      //     for (var schedule in widget.tour.tourSchedule!)
      //       ListTile(
      //         title: Text(
      //           schedule.title ?? 'No Title',
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         subtitle: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(schedule.description ?? 'No Description'),
      //             const SizedBox(height: 8.0),
      //             if (schedule.tourScheduleDetails != null &&
      //                 schedule.tourScheduleDetails!.isNotEmpty)
      //               for (var detail in schedule.tourScheduleDetails!)
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Container(
      //                           width: 8,
      //                           height: 8,
      //                           decoration: const BoxDecoration(
      //                             shape: BoxShape.circle,
      //                             color: primaryColor,
      //                           ),
      //                         ),
      //                         Text(
      //                           ' ${detail.from} - ${detail.to}',
      //                         ),
      //                       ],
      //                     ),
      //                     Text("${detail.description}")
      //                   ],
      //                 )
      //           ],
      //         ),
      //       ),
      //   ],
      // ),
      const Titles(
        title: "Schedules",
      ),
      TourScheduleWidget(tourSchedules: widget.tour.tourSchedule!),

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
                    children: [
                      CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              widget.tour.provider?.avatarImageUrl != null
                                  ? CachedNetworkImageProvider(
                                      '${widget.tour.provider?.avatarImageUrl}')
                                  : null),
                      const SizedBox(height: 8),
                      Text(widget.tour.provider?.companyName ?? "Company name",
                          style: Theme.of(context).textTheme.titleMedium)
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 18),
                          const SizedBox(width: 4),
                          Text('4.5',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('123 Reviews',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 4),
                      Text(joinedAgo(widget.tour.provider!.createdAt!),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Display user reviews
      const Titles(
        title: "What do people think?",
      ),
      const SizedBox(
        height: 12,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 1; i <= 10; i++) ReviewWidget(rating: rating),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                print("See All Reviews");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "See All",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 100,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tour.name ?? "Place details",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // context
              //     .read<RemoteTourBloc>()
              //     .add(AddToWishlist(widget.tour.id!));
            },
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
                children: scheduleDetail,
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
                      '${widget.tour.pricingTicket?[0].priceRange?[0].price}₫',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
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
                        return BookingBottomSheet(tour: widget.tour);
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

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.rating,
  });

  final int rating;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: colorLightGrey!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      "https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg"),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "User name",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating.floor() ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                );
              }),
            ),
            const SizedBox(height: 4),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

String joinedAgo(DateTime createdAt) {
  final DateTime now = DateTime.now();

  final int months =
      (now.year - createdAt.year) * 12 + now.month - createdAt.month;

  return 'Joined $months ${months == 1 ? 'month' : 'months'} ago';
}

List<Widget> _buildChips(List<dynamic>? chips, String chipType) {
  if (chips == null || chips.isEmpty) {
    return [const Text('No available')];
  }

  return chips.map((chips) {
    String iconName = chips.name ?? 'default_icon';
    String iconAssetPath = 'assets/icons/$chipType/$iconName.svg';

    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          iconAssetPath,
          height: 24,
          width: 24,
        ),
      ),
      label: Text(chips.name.toString()),
    );
  }).toList();
}
