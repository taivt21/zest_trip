import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/features/auth/data/data_sources/authentication_api_service.dart';
import 'package:zest_trip/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zest_trip/features/auth/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_bloc.dart';
import 'package:zest_trip/features/auth/presentation/screens/login_screen.dart';
import 'package:zest_trip/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Khởi tạo AuthRepository và AuthBloc
  final authRepository = AuthRepositoryImpl(AuthApiService());
  final authBloc = AuthBloc(
    loginWithEmailAndPasswordUseCase:
        LoginWithEmailAndPasswordUseCase(authRepository),
    registerWithEmailAndPasswordUseCase:
        RegisterWithEmailAndPasswordUseCase(authRepository),
    signInWithGoogleUseCase: GoogleSignInUseCase(authRepository),
  );

  runApp(MyApp(authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      child: const MaterialApp(
        title: 'ZestTrip',
        home: LoginScreen(),
      ),
    );
  }
}
