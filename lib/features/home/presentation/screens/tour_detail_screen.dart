import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/map_tour_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/review_of_tour_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_detail.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_schedule_detail_widget.dart';
import 'package:zest_trip/features/payment/presentation/widgets/bottomsheet_booking.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourDetailScreen extends StatefulWidget {
  final TourEntity tour;

  const TourDetailScreen({Key? key, required this.tour}) : super(key: key);

  @override
  TourDetailScreenState createState() => TourDetailScreenState();
}

class TourDetailScreenState extends State<TourDetailScreen> {
  bool isExpanded = false;
  final int maxLines = 10;

  int _currentPage = 0;
  final PageController _pageController = PageController();
  bool showReadMore = false;
  TourReviewEntity? tourRevies;

  GoogleMapController? mapController;
  Set<Marker> markers = {};
  late double lat;
  late double long;
  late double zoom;
  late LatLng showLocation;
  @override
  void dispose() {
    mapController!.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    zoom = double.parse(widget.tour.departureLocation?["zoom"]
        .replaceAll(RegExp('[a-zA-Z]'), ''));

    showLocation = LatLng(double.parse(widget.tour.departureLocation?["lat"]),
        double.parse(widget.tour.departureLocation?["long"]));
    markers.add(Marker(
      markerId: MarkerId(showLocation.toString()),
      position: showLocation,
      infoWindow: InfoWindow(
        title: '${widget.tour.name}',
        snippet: "${widget.tour.addressProvince}",
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String tourId = widget.tour.id!;
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
      Text(
          '${widget.tour.addressWard}, ${widget.tour.addressDistrict}, ${widget.tour.addressProvince}',
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
          GestureDetector(
            onTap: () {
              if (widget.tour.count?['TourReview'] > 0) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewsOfTour(
                          tourId: widget.tour.id!,
                          ratingCount: widget.tour.count?["TourReview"] ?? 0,
                          ratingTour: widget.tour.avgRating ?? "0",
                        )));
              }
            },
            child: RichText(
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
          ),
          Text(
            "${widget.tour.count?['TourReview']} booked",
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),

      const SizedBox(height: 4),
      widget.tour.durationDay == 0
          ? Text(
              widget.tour.duration! > 1
                  ? 'Duration: ${widget.tour.duration} days'
                  : 'Duration: ${widget.tour.duration} day',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            )
          : Text(
              "Duration: ${widget.tour.durationDay}D ${widget.tour.durationNight}N",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
      const SizedBox(height: 8),
      const Titles(title: "About"),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorHyperlinkSecondary,
        ),
        child: ReadMoreText(
          "${widget.tour.description!} ",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
          trimLines: 8,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              decoration: TextDecoration.underline),
          lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
        ),
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
      const Titles(
        title: "Departure location",
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        widget.tour.departureLocation?["location"],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
      ),
      const SizedBox(
        height: 8,
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Maps(
                lat: widget.tour.departureLocation?["lat"],
                long: widget.tour.departureLocation?["long"],
                zoom: widget.tour.departureLocation?["zoom"],
                location: widget.tour.departureLocation?["location"],
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          height: 150,
          child: GoogleMap(
            myLocationEnabled: false,
            zoomGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              target: showLocation,
              zoom: zoom,
            ),
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
        ),
      ),

      const SizedBox(height: 8),
      const Titles(
        title: "Schedules",
      ),
      const SizedBox(height: 8),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: fourthColor,
          ),
          child: TourScheduleWidget(
            tourSchedules: widget.tour.tourSchedule!,
            showMore: true,
          )),

      const SizedBox(height: 8),

      // Display host information
      Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ProviderProfileScreeen(
            //             providerId: widget.tour.providerId!)));
          },
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
                            backgroundColor: whiteColor,
                            backgroundImage: widget
                                        .tour.provider?.avatarImageUrl !=
                                    null
                                ? CachedNetworkImageProvider(
                                    '${widget.tour.provider?.avatarImageUrl}')
                                : null),
                        const SizedBox(height: 8),
                        Text(
                            widget.tour.provider?.companyName ?? "Company name",
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
                            Text(widget.tour.provider?.avgRating ?? "4.4",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        widget.tour.provider != null
                            ? Text(joinedAgo(widget.tour.provider!.createdAt!),
                                style: Theme.of(context).textTheme.bodyMedium)
                            : const Text(""),
                      ],
                    ),
                  ),
                ],
              ),
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
      Row(
        children: [
          Expanded(
            child: BlocBuilder<TourReviewsBloc, TourReviewsState>(
              builder: (context, reviewState) {
                debugPrint("reviewstate: ${reviewState.reviews}");
                if (reviewState is GetReviewsSuccess) {
                  if (reviewState.reviews == null ||
                      reviewState.reviews!.isEmpty) {
                    return const Text("No reviews");
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < reviewState.reviews!.length; i++)
                          ReviewWidget(
                            tourReviews: TourReviewEntity(
                              user: reviewState.reviews?[i].user,
                              userId: reviewState.reviews?[i].user?.fullName ??
                                  "Anonymous",
                              rating: reviewState.reviews?[i].rating,
                              description: reviewState.reviews?[i].description,
                            ),
                          ),
                      ],
                    ),
                  );
                } else if (reviewState is TourReviewsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text("Something wrong ${reviewState.error}");
                }
              },
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      BlocBuilder<TourReviewsBloc, TourReviewsState>(
        builder: (context, reviewState) {
          bool hasReviews = reviewState is GetReviewsSuccess &&
              reviewState.reviews != null &&
              reviewState.reviews!.isNotEmpty;

          return SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                if (hasReviews) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReviewsOfTour(
                            tourId: widget.tour.id!,
                            ratingCount: widget.tour.count?["TourReview"] ?? 0,
                            ratingTour: widget.tour.avgRating ?? "0",
                          )));
                }
              },
              icon: const Icon(Icons.more_horiz_rounded),
              label: const Text("See all reviews"),
            ),
          );
        },
      ),

      const SizedBox(
        height: 100,
      )
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourReviewsBloc>(
          create: (context) => sl()..add(GetTourReviews(tourId)),
        ),
      ],
      child: Scaffold(
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoZoomScreen(
                                  imageUrls: widget.tour.tourImages!,
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
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
                          ),
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
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        '${NumberFormatter.format(num.parse(widget.tour.pricingTicket![0].fromPrice!))}₫',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 6,
                      child: ElevatedButtonCustom(
                        onPressed: () {
                          (state is AuthSuccess)
                              ? showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16))),
                                  context: context,
                                  builder: (context) {
                                    return BookingBottomSheet(
                                        tour: widget.tour);
                                  },
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please login to booking!'),
                                  ),
                                );
                        },
                        text: tCheckAvailable,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String joinedAgo(DateTime createdAt) {
  final DateTime now = DateTime.now();

  final int months =
      (now.year - createdAt.year) * 12 + now.month - createdAt.month;

  if (months == 0) {
    final int days = now.difference(createdAt).inDays;
    return 'Joined $days ${days == 1 ? 'day' : 'days'} ago';
  } else {
    return 'Joined $months ${months == 1 ? 'month' : 'months'} ago';
  }
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
