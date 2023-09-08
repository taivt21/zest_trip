import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/bloc_observer.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/tour_bloc_ex.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/firebase_options.dart';
import 'package:zest_trip/get_it.dart';

void main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  logger.i('Firebase is connected: ${Firebase.apps.isNotEmpty}');
  // log BlocObserver
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RemoteTourBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<TourTagBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final tourBloc =
  //     RemoteTourBloc(GetTourUseCase(TourRepositoryImpl(TourApiServiceIml())));

  // final tourTagBloc =
  //     TourTagBloc(GetTourTagsUseCase(TourRepositoryImpl(TourApiServiceIml())));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          fontFamily: 'AirbnbCereal',
          useMaterial3: true,
        ),
        // darkTheme: ThemeData(brightness: Brightness.dark),
        title: 'ZestTrip',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
