import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/bloc_observer.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/repository/tour_repository_impl.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tags.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/tour_bloc_ex.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour_resource/remote/tags/tour_tag_bloc.dart';
import 'package:zest_trip/firebase_options.dart';

void main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  logger.i('Firebase is connected: ${Firebase.apps.isNotEmpty}');
  // log BlocObserver
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepository = AuthRepositoryImpl(AuthApiServiceImpl());

  final tourRepository = TourRepositoryImpl(TourRemoteDataSourceIml());

  final authBloc = AuthBloc(
    LogoutUseCase(AuthRepositoryImpl(AuthApiServiceImpl())),
    SignInWithPhoneNumberUseCase(AuthRepositoryImpl(AuthApiServiceImpl())),
    LoginWithEmailAndPasswordUseCase(
      AuthRepositoryImpl(AuthApiServiceImpl()),
    ),
    RegisterWithEmailAndPasswordUseCase(
        AuthRepositoryImpl(AuthApiServiceImpl())),
    SignInWithGoogleUseCase(AuthRepositoryImpl(AuthApiServiceImpl())),
  );

  final tourBloc = RemoteTourBloc(
      GetTourUseCase(TourRepositoryImpl(TourRemoteDataSourceIml())));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //   BlocProvider<AuthBloc>.value(
        //     value: authBloc,
        //   ),
        //   BlocProvider<RemoteTourBloc>.value(
        //     value: tourBloc,
        //   ),
        BlocProvider<RemoteTourBloc>(
          create: (context) => tourBloc
            ..add(
              const GetTours(),
            ),
        ),
        BlocProvider<TourTagBloc>(
          create: (context) => TourTagBloc(
            GetTourTagsUseCase(
              TourRepositoryImpl(TourRemoteDataSourceIml()),
            ),
          )..add(const GetTourTags()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
        ),
        // BlocProvider<RemoteTourBloc>(
        //   create: (_) => tourBloc,
        // ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(fontFamily: 'AirbnbCereal', useMaterial3: true),
        // darkTheme: ZAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: 'ZestTrip',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
