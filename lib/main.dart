import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/bloc_observer.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour_resource/remote/vehicles/tour_vehicle_bloc.dart';
import 'package:zest_trip/firebase_options.dart';
import 'package:zest_trip/get_it.dart';

void main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    initializeDependencies()
  ]);
  logger.i('Firebase is connected: ${Firebase.apps.isNotEmpty}');

  Bloc.observer = MyBlocObserver();
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
        BlocProvider<TourVehicleBloc>(
          create: (context) => sl()..add(const GetTourVehicles()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl()..add(CheckUserLoginEvent()),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: primaryColor),
          fontFamily: 'Airbnb',
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
