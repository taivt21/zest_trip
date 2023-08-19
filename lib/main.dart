import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/bloc_observer.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/theme/app_themes.dart';
import 'package:zest_trip/features/authentication/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase is connected: ${Firebase.apps.isNotEmpty}');
  // log BlocObserver
  Bloc.observer = MyBlocObserver();

  final authRepository = AuthRepositoryImpl(AuthApiServiceImpl());

  final authBloc = AuthBloc(
    LogoutUseCase(authRepository),
    SignInWithPhoneNumberUseCase(authRepository),
    LoginWithEmailAndPasswordUseCase(
      authRepository,
    ),
    RegisterWithEmailAndPasswordUseCase(authRepository),
    SignInWithGoogleUseCase(authRepository),
  );

  runApp(
    BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.login, // Set the initial route
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ZAppTheme.lightTheme,
      darkTheme: ZAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: 'ZestTrip',
    );
  }
}
