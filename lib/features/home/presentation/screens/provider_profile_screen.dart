import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/resources/date_format.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_of_provider/tour_of_provider_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/photo_zoom_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/search_query_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/gridview_tour.dart';
import 'package:zest_trip/features/home/presentation/widgets/report_provider_modal.dart';
import 'package:zest_trip/features/home/presentation/widgets/titles_common.dart';
import 'package:zest_trip/features/payment/presentation/bloc/provider/provider_bloc.dart';
import 'package:zest_trip/get_it.dart';

class ProviderProfileScreen extends StatefulWidget {
  final String providerId;

  const ProviderProfileScreen({Key? key, required this.providerId})
      : super(key: key);

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}

class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  String search = "";
  @override
  void initState() {
    search = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProviderBloc>(
            create: (context) =>
                sl()..add(GetProviderEvent(providerId: widget.providerId)),
          ),
          BlocProvider<TourProviderBloc>(
            create: (context) =>
                sl()..add(GetTourProvider(widget.providerId, search: search)),
          ),
        ],
        child: BlocBuilder<TourProviderBloc, TourProviderState>(
          builder: (context, tourState) {
            return BlocBuilder<ProviderBloc, ProviderState>(
              builder: (context, state) {
                if (state is GetInfoProviderSuccess) {
                  List<String> socialmedia = state.providerEntity!.socialMedia!;

                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: height * 0.2,
                        floating: false,
                        pinned: true,
                        backgroundColor: primaryColor,
                        flexibleSpace: FlexibleSpaceBar(
                          background: GestureDetector(
                            onTap: () {
                              List<String> url = [];
                              url.add(state.providerEntity?.bannerImageUrl ??
                                  "https://cdn.pixabay.com/photo/2017/08/20/10/47/grey-2661270_1280.png");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoZoomScreen(
                                    imageUrls: url,
                                    initialIndex: 1,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorBoldGrey!.withOpacity(0.9),
                                image: DecorationImage(
                                  opacity: 0.5,
                                  image: CachedNetworkImageProvider(
                                    state.providerEntity!.bannerImageUrl!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    bottom: 15,
                                    left: 15,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    state.providerEntity!
                                                        .avatarImageUrl!,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // const Row(
                                                      //   children: [
                                                      // const SizedBox(
                                                      //   width: 8,
                                                      // ),
                                                      // const Icon(
                                                      //   Icons.arrow_forward_ios,
                                                      //   size: 16,
                                                      //   color: whiteColor,
                                                      // )
                                                      //   ],
                                                      // ),
                                                      Text(
                                                        "${state.providerEntity?.companyName}",
                                                        style: textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                fontSize: 18,
                                                                color:
                                                                    whiteColor),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        "${state.providerEntity?.addressProvince}",
                                                        style: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color:
                                                                    whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star_rounded,
                                                            size: 16,
                                                            color: Colors.amber,
                                                          ),
                                                          Text(
                                                            " ${state.providerEntity?.avgRating}/5.0",
                                                            style: textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color:
                                                                        whiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        title: GestureDetector(
                          onTap: () async {
                            final searchLocation = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchQueryScreen(),
                              ),
                            );

                            if (searchLocation != null) {
                              setState(() {
                                search = searchLocation;
                              });
                              final tourProvider =
                                  BlocProvider.of<TourProviderBloc>(context);
                              tourProvider.add(const ClearTourProvider());
                              tourProvider.add(GetTourProvider(
                                  widget.providerId,
                                  search: searchLocation));
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: colorBoldGrey!.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    search != ""
                                        ? search
                                        : "Search in provider...",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: whiteColor,
                                        )),
                                const Expanded(child: SizedBox()),
                                const Icon(
                                  Icons.search,
                                  color: whiteColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          Tooltip(
                            message: 'Report',
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      child: ReportModal(
                                          providerId: widget.providerId),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.more_horiz_outlined,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                        foregroundColor: whiteColor,
                      ),
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Titles(title: "About company"),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.house_rounded,
                                      "Company name",
                                      state.providerEntity?.companyName ?? "",
                                      textTheme,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.travel_explore,
                                      "Service type",
                                      state.providerEntity?.serviceType ?? "",
                                      textTheme,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.location_on_rounded,
                                      "Address",
                                      "${state.providerEntity?.addressName}, ${state.providerEntity?.addressWard}, ${state.providerEntity?.addressDistrict}, ${state.providerEntity?.addressProvince}",
                                      textTheme,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.email,
                                      "Email contact",
                                      state.providerEntity?.email ?? "",
                                      textTheme,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.phone,
                                      "Phone",
                                      state.providerEntity?.phone ?? "",
                                      textTheme,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    buildTextWithIcon(
                                      Icons.person,
                                      "Participant",
                                      DateTimeHelper.joinedAgo(
                                          state.providerEntity!.createdAt!),
                                      textTheme,
                                    ),
                                    for (int i = 0; i < socialmedia.length; i++)
                                      buildTextWithIcon(
                                          Icons.link,
                                          "Social meida",
                                          socialmedia[i],
                                          textTheme)
                                  ],
                                ),
                              ),
                              GridViewTour(
                                tours: tourState.tours ?? [],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is ProviderInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text("${state.error?.response?.data["message"]}");
                }
              },
            );
          },
        ),
      ),
    );
  }
}

Widget buildTextWithIcon(
  IconData icon,
  String label,
  String value,
  TextTheme textTheme,
) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              icon,
              color: colorBoldGrey,
            ),
          ),
        ),
        TextSpan(
          text: "$label ",
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        TextSpan(
          text: value,
          style: textTheme.titleMedium,
        ),
      ],
    ),
  );
}
