import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_event.dart';
import 'package:zest_trip/features/home/presentation/blocs/location_popular/location_popular_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_of_provider/tour_of_provider_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_location/tour_recommend_location_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_search/tour_recommend_search_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_recommend_tag/tour_recommend_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/district/district_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tags/tour_tag_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/tour_detail/tour_detail_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_resource/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_sponsore/tour_sponsore_bloc.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/booking/booking_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/checking_tour/checking_tour_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/my_review/my_review_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/refund/refund_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/report_provider/report_provider_bloc.dart';
import 'package:zest_trip/features/payment/presentation/bloc/voucher/voucher_bloc.dart';
import 'package:zest_trip/firebase_options.dart';
import 'package:zest_trip/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    initializeDependencies(),
  ]);

  // Bloc.observer = MyBlocObserver();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl()..add(CheckUserLoginEvent()),
        ),
        BlocProvider<TourVehicleBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<RemoteTourBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourDetailBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourTagBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<DistrictBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<RefundBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<VoucherBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourRecommendLocationBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourRecommendTagBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourRecommendSearchBloc>(
          create: (context) => sl()..add(const GetToursRcmSearch()),
        ),
        BlocProvider<LocationPopularBloc>(
          create: (context) => sl()..add(const GetPopularLocation()),
        ),
        BlocProvider<TourSponsoreBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<MyReviewBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourProviderBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<TourWishlistBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ReportProviderBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<CheckingTourBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder()
          }),
          colorScheme: const ColorScheme.light(primary: primaryColor),
          fontFamily: 'SFCompact',
          useMaterial3: true,
          scaffoldBackgroundColor: bgColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        themeMode: ThemeMode.system,

        // darkTheme: ThemeData(brightness: Brightness.dark),
        title: 'Zest Travel',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
