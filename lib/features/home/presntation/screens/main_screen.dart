import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';
import 'package:zest_trip/features/home/presntation/widgets/category.dart';
import 'package:zest_trip/features/home/presntation/widgets/destination.dart';
import 'package:zest_trip/features/home/presntation/widgets/populate.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  return Row(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              authState is AuthSuccess
                                  ? authState.user.avatarImageUrl ?? tBannerQC
                                  : tBannerQC,
                            ),
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            authState is AuthSuccess
                                ? authState.user.fullName ?? "Username"
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
                        Icons.notifications_none_rounded,
                        size: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.search),
                  const SizedBox(width: 8),
                  Text(
                    "Search any location...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Category(
                      text: "City",
                      color: primaryColor,
                    ),
                    Category(
                      text: "Beach",
                      color: primaryColor,
                    ),
                    Category(
                      text: "Mountain",
                      color: primaryColor,
                    ),
                    Category(
                      text: "Forest",
                      color: primaryColor,
                    ),
                    Category(
                      text: "Adventure",
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Popular Destination",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            const PopularDestinationWidget(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special For You",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    child: Text(
                      "Explore All",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primaryColor,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.landingScreen);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const ForYouDestinationWidget(),
          ],
        ),
      ),
    );
  }
}
