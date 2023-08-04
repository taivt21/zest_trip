import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/theme/app_themes.dart';
import 'package:zest_trip/features/auth/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/auth/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/auth/presentation/screens/signup_screen.dart';
import 'package:zest_trip/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase is connected: ${Firebase.apps.isNotEmpty}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        LogoutUseCase(AuthRepositoryImpl(AuthApiServiceImpl())),
        SignInWithPhoneNumberUseCase(AuthRepositoryImpl(AuthApiServiceImpl())),
        loginWithEmailAndPasswordUseCase: LoginWithEmailAndPasswordUseCase(
          AuthRepositoryImpl(AuthApiServiceImpl()),
        ),
        registerWithEmailAndPasswordUseCase:
            RegisterWithEmailAndPasswordUseCase(
          AuthRepositoryImpl(AuthApiServiceImpl()),
        ),
        signInWithGoogleUseCase: SignInWithGoogleUseCase(
          AuthRepositoryImpl(AuthApiServiceImpl()),
        ),
      ),
      child: MaterialApp(
        initialRoute: AppRoutes.login, // Set the initial route
        onGenerateRoute: AppRoutes.generateRoute,
        theme: ZAppTheme.lightTheme,
        darkTheme: ZAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: 'ZestTrip',
        home: const SignUpScreen(),
      ),
    );
  }
}
