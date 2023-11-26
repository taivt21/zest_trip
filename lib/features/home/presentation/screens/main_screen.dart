import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_location/tour_recommend_location_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_tag/tour_recommend_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/select_hobby_screen.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';
import 'package:zest_trip/features/home/presentation/widgets/card_recommend_location.dart';
import 'package:zest_trip/get_it.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider<TourRecommendLocationBloc>(
          create: (context) => sl()..add(const GetToursRcmLocation()),
        ),
        BlocProvider<TourRecommendTagBloc>(
          create: (context) => sl()..add(const GetToursRcmTag()),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderMainScreen(),
                const SizedBox(
                  height: 16,
                ),
                const SearchMainScreen(),
                const SizedBox(
                  height: 16,
                ),
                // LocationRecommend(widthScreen: widthScreen),
                const SizedBox(
                  height: 40,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/qc.png")),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Experience not to be missed",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: thirdColor.withOpacity(0.4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(locationSvg, height: 28),
                              Text(
                                " Popular tour locations",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SelectHobbyScreen()));
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<TourRecommendLocationBloc,
                          TourRecommendLocationState>(
                        builder: (context, state) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                state.tours?.length ?? 0,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TourDetailScreen(
                                            tour: state.tours![index]),
                                      ),
                                    );
                                  },
                                  child: CardRecommendLocation(
                                    tour: state.tours![index],
                                    width: widthScreen * 0.35,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: fourthColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(travelSvg, height: 28),
                              Text(
                                "  Popular types of tours",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<TourRecommendTagBloc, TourRecommendTagState>(
                        builder: (context, state) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                state.tours?.length ?? 0,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TourDetailScreen(
                                            tour: state.tours![index]),
                                      ),
                                    );
                                  },
                                  child: CardRecommendLocation(
                                    tour: state.tours![index],
                                    width: widthScreen * 0.35,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: secondaryColor.withOpacity(0.4),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tour recommendation (♥_♥)",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: List.generate(
                      //       5,
                      //       (index) => CardRecommendLocation(
                      //         tour: state.tours![index],
                      //         width: widthScreen * 0.35,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // CustomScrollTabBar(
                //   categories: context.watch<TourTagBloc>().state.tourTags ?? [],
                //   onTabChanged: (index) {
                //     // Do something when tab is changed
                //   },
                // ),
                const SizedBox(height: 20),

                // GridView.count(
                //   crossAxisCount: 2,
                //   crossAxisSpacing: 16,
                //   mainAxisSpacing: 16,
                //   children: List.generate(2, (index) {
                //     return CardRecommendLocation(
                //       price: 120000,
                //       width: widthScreen * 0.35,
                //       imageUrl:
                //           "https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg",
                //       title: "Da Nang",
                //       numberOfActivities: 100,
                //     );
                //   }),
                // ),
                // const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.landingScreen);
                    },
                    icon: const Icon(Icons.more_horiz_rounded),
                    label: const Text("Explore all"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class LocationRecommend extends StatelessWidget {
//   const LocationRecommend({
//     super.key,
//     required this.widthScreen,
//   });

//   final double widthScreen;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(
//           5,
//           (index) => CardRecommendLocation(
//             width: widthScreen * 0.35,
//             imageUrl:
//                 "https://baoanhdatmui.vn/wp-content/uploads/2023/02/du-lich-da-nang.jpg",
//             title: "Da Nang",
//             numberOfActivities: 100,
//           ),
//         ),
//       ),
//     );
//   }
// }

class SearchMainScreen extends StatelessWidget {
  const SearchMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: colorLightGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.location_on),
          const SizedBox(width: 8),
          Text("Your location",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderMainScreen extends StatelessWidget {
  const HeaderMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Row(
          children: [
            authState is AuthSuccess
                ? SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: CachedNetworkImage(
                          imageUrl: authState.user!.avatarImageUrl!,
                          placeholder: (context, url) => Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(color: colorLightGrey),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(color: colorLightGrey),
                          ),
                        )),
                  )
                : Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(color: colorLightGrey),
                  ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authState is AuthSuccess
                      ? authState.user?.fullName ?? "Username"
                      : "Username",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Where do you want to go ?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.notifications_outlined,
              size: 32,
            ),
          ],
        );
      },
    );
  }
}
