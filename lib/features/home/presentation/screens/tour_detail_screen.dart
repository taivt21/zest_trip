// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import 'package:zest_trip/config/theme/custom_elevated_button.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/text_constant.dart';
import 'package:zest_trip/config/utils/resources/date_format.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/reviews/tour_reviews_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tour_detail/tour_detail_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/map_tour_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/provider_profile_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/review_of_tour_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/review_detail.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/features/home/presentation/widgets/tour_schedule_detail_widget.dart';
import 'package:zest_trip/features/payment/presentation/widgets/bottomsheet_booking.dart';
import 'package:zest_trip/get_it.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;

  const TourDetailScreen({
    Key? key,
    required this.tourId,
  }) : super(key: key);

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
    mapController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourDetailBloc>(
          create: (context) => sl()..add(GetTourDetail(widget.tourId)),
        ),
        BlocProvider<TourReviewsBloc>(
          create: (context) => sl()..add(GetTourReviews(widget.tourId)),
        ),
        BlocProvider<TourWishlistBloc>(
          create: (context) => sl()..add(const GetWishlist()),
        ),
      ],
      child: BlocBuilder<TourDetailBloc, TourDetailState>(
        builder: (context, tourDetailState) {
          if (tourDetailState is GetTourDetailSuccess) {
            lat = double.parse(tourDetailState.tour?.departureLocation!["lat"]);
            long =
                double.parse(tourDetailState.tour?.departureLocation!["long"]);
            zoom = double.parse(tourDetailState.tour?.departureLocation!["zoom"]
                .replaceAll(RegExp('[a-zA-Z]'), ''));
            showLocation = LatLng(lat, long);
            markers.add(Marker(
              markerId: MarkerId(showLocation.toString()),
              position: showLocation,
              infoWindow: InfoWindow(
                title: '${tourDetailState.tour?.name}',
                snippet: "${tourDetailState.tour?.addressProvince}",
              ),
              icon: BitmapDescriptor.defaultMarker,
            ));
            return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                title: Text(
                  tourDetailState.tour?.name ?? "Place details",
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  BlocBuilder<TourWishlistBloc, TourWishlistState>(
                    builder: (context, state) {
                      bool isFavorited = state.tours != null &&
                          state.tours!.any((tour) => tour.id == widget.tourId);

                      return IconButton(
                        onPressed: () {
                          if (isFavorited) {
                            Fluttertoast.showToast(
                              msg: "Removed!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                            );
                            context.read<TourWishlistBloc>().add(
                                  RemoveWishlist(widget.tourId),
                                );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Added wishlist",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                            );
                            context.read<TourWishlistBloc>().add(
                                  AddWishlist(widget.tourId),
                                );
                          }
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: isFavorited
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                        ),
                      );
                    },
                  )
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
                            itemCount: tourDetailState.tour?.tourImages!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoZoomScreen(
                                        imageUrls:
                                            tourDetailState.tour?.tourImages ??
                                                [],
                                        initialIndex: index,
                                      ),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      tourDetailState.tour!.tourImages![index],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: const Color.fromARGB(
                                        255, 116, 112, 112),
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
                              '${_currentPage + 1}/${tourDetailState.tour?.tourImages!.length}',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                            tourDetailState.tour?.name ?? "tour.name",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                              '${tourDetailState.tour?.addressWard}, ${tourDetailState.tour?.addressDistrict}, ${tourDetailState.tour?.addressProvince}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow[800], size: 16),
                              const SizedBox(width: 4),
                              Text('${tourDetailState.tour?.avgRating} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.yellow[800],
                                          fontWeight: FontWeight.w400)),
                              GestureDetector(
                                onTap: () {
                                  if (tourDetailState
                                          .tour?.count?['TourReview'] >
                                      0) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ReviewsOfTour(
                                                  tourId:
                                                      tourDetailState.tour!.id!,
                                                  ratingCount: tourDetailState
                                                              .tour!.count?[
                                                          "TourReview"] ??
                                                      0,
                                                  ratingTour: tourDetailState
                                                          .tour?.avgRating ??
                                                      "0",
                                                )));
                                  }
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '(${tourDetailState.tour?.count?['TourReview']}  ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: 'reviews',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.underline)),
                                      TextSpan(text: ") • ")
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "${tourDetailState.tour?.count?['TourReview']} booked",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),
                          tourDetailState.tour?.durationDay == 0
                              ? Text(
                                  tourDetailState.tour!.duration! > 1
                                      ? 'Duration: ${tourDetailState.tour?.duration} days'
                                      : 'Duration: ${tourDetailState.tour?.duration} day',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  "Duration: ${tourDetailState.tour?.durationDay}D ${tourDetailState.tour?.durationNight}N",
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
                              "${tourDetailState.tour?.description} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 16),
                              trimLines: 8,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      decoration: TextDecoration.underline),
                              lessStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Wrap(
                            spacing: 8,
                            children:
                                _buildChips(tourDetailState.tour?.tags, "tags"),
                          ),
                          const SizedBox(height: 8),
                          const Titles(title: "Footnote"),
                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                border: Border.all(color: Colors.yellow[700]!),
                                borderRadius: BorderRadius.circular(16)),
                            child: ReadMoreText(
                              '${tourDetailState.tour?.footnote}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              trimLines: 8,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      decoration: TextDecoration.underline),
                              lessStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Titles(
                            title: "Vehicles",
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _buildChips(
                                tourDetailState.tour?.vehicles, "vehicles"),
                          ),
                          const SizedBox(height: 8),
                          const Titles(
                            title: "Departure location",
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: (tourDetailState.tour
                                            ?.departureLocation?["location"]
                                        as List?)
                                    ?.asMap()
                                    .entries
                                    .map(
                                      (location) => GestureDetector(
                                        onLongPress: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${location.value?["deparute"]}'));
                                          Fluttertoast.showToast(
                                            msg:
                                                "Location copied to clipboard!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            children: [
                                              TextSpan(
                                                text:
                                                    '•  Place ${location.key + 1}:',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              if (location.value?["deparute"] !=
                                                  null)
                                                TextSpan(
                                                  text:
                                                      ' ${location.value?["deparute"]} - at ',
                                                ),
                                              if (location.value?["time"] !=
                                                      null &&
                                                  location.value?["time"]
                                                      .isNotEmpty)
                                                TextSpan(
                                                  text:
                                                      '${location.value?["time"]} ${NumberFormatter.checkAmPm(location.value?["time"])}',
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                [],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Titles(
                            title: "Operating location",
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
                                    lat: double.parse(tourDetailState
                                        .tour?.departureLocation!["lat"]),
                                    long: double.parse(tourDetailState
                                        .tour?.departureLocation?["long"]),
                                    zoom: double.parse(tourDetailState
                                        .tour?.departureLocation?["zoom"]),
                                    // location: tourDetailState
                                    //     .tour?.departureLocation?["location"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              margin: const EdgeInsets.all(8),
                              width: double.infinity,
                              height: 240,
                              child: GoogleMap(
                                zoomGesturesEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: showLocation,
                                ),
                                markers: markers,
                                mapType: MapType.normal,
                                onMapCreated: (controller) {
                                  setState(() {
                                    mapController = controller;
                                  });
                                },
                                minMaxZoomPreference:
                                    const MinMaxZoomPreference(10, 15),
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
                                tourSchedules:
                                    tourDetailState.tour?.tourSchedule ?? [],
                                showMore: true,
                              )),

                          const SizedBox(height: 8),

                          // Display host information
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProviderProfileScreen(
                                            providerId: tourDetailState
                                                .tour!.provider!.id!,
                                          )));
                            },
                            child: Card(
                              color: whiteColor,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                              radius: 40,
                                              backgroundColor: whiteColor,
                                              backgroundImage: tourDetailState
                                                          .tour!
                                                          .provider
                                                          ?.avatarImageUrl !=
                                                      null
                                                  ? CachedNetworkImageProvider(
                                                      '${tourDetailState.tour?.provider?.avatarImageUrl}')
                                                  : null),
                                          const SizedBox(height: 8),
                                          Text(
                                              tourDetailState.tour?.provider
                                                      ?.companyName ??
                                                  "Company name",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                size: 18,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                  tourDetailState.tour?.provider
                                                          ?.avgRating ??
                                                      "Rating",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                              tourDetailState.tour?.provider
                                                      ?.addressProvince ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                          const SizedBox(height: 4),
                                          tourDetailState.tour?.provider != null
                                              ? Text(
                                                  "Joined ${DateTimeHelper.joinedAgo(tourDetailState.tour!.provider!.createdAt!)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium)
                                              : const Text(""),
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

                          BlocBuilder<TourReviewsBloc, TourReviewsState>(
                            builder: (context, reviewState) {
                              if (reviewState is GetReviewsSuccess) {
                                if (reviewState.reviews == null ||
                                    reviewState.reviews!.isEmpty) {
                                  return const Text("No reviews");
                                }
                                return Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  (reviewState.reviews!.length >
                                                          5
                                                      ? 5
                                                      : reviewState
                                                          .reviews!.length);
                                              i++)
                                            ReviewWidget(
                                              tourReviews: TourReviewEntity(
                                                user: reviewState
                                                    .reviews?[i].user,
                                                userId: reviewState.reviews?[i]
                                                        .user?.fullName ??
                                                    "Username",
                                                rating: reviewState
                                                    .reviews?[i].rating,
                                                description: reviewState
                                                    .reviews?[i].description,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          if (reviewState.reviews!.isNotEmpty) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReviewsOfTour(
                                                          tourId:
                                                              tourDetailState
                                                                  .tour!.id!,
                                                          ratingCount: tourDetailState
                                                                      .tour
                                                                      ?.count?[
                                                                  "TourReview"] ??
                                                              0,
                                                          ratingTour:
                                                              tourDetailState
                                                                      .tour
                                                                      ?.avgRating ??
                                                                  "0",
                                                        )));
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.more_horiz_rounded),
                                        label: const Text("See all reviews"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                );
                              } else if (reviewState is TourReviewsInitial) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Text(
                                    "Something wrong ${reviewState.error}");
                              }
                            },
                          ),

                          const SizedBox(
                            height: 80,
                          )
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
                              '${NumberFormatter.format(num.parse(tourDetailState.tour!.pricingTicket![0].fromPrice!))}₫',
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
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.95,
                                            child: BookingBottomSheet(
                                                tour: tourDetailState.tour!),
                                          );
                                        },
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please login to booking!'),
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
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
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
