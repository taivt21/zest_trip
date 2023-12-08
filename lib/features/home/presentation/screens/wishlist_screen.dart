import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/image_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/home/presentation/widgets/empty_widget.dart';
import 'package:zest_trip/features/home/presentation/widgets/gridview_tour.dart';
import 'package:zest_trip/get_it.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My wishlist'),
      ),
      body: BlocProvider<TourWishlistBloc>(
        create: (context) => sl()..add(const GetWishlist()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<TourWishlistBloc>(context)
                      .add(const GetWishlist());
                },
                child: BlocBuilder<TourWishlistBloc, TourWishlistState>(
                  builder: (context, state) {
                    if (state is TourWishlistInitial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetToursWishlistSuccess) {
                      return state.tours!.isNotEmpty && state.tours != null
                          ? GridViewTour(tours: state.tours!)
                          : const EmptyWidget(
                              imageSvg: travelSvg, title: "No wishlist found");
                    } else {
                      return Text("${state.error?.response?.data["message"]}");
                    }
                  },
                ),
              );
            } else {
              return const Center(
                child: EmptyWidget(imageSvg: loginSvg, title: "Please login"),
              );
            }
          },
        ),
      ),
    );
  }
}
