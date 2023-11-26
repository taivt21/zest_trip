import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/domain/usecases/upload_image_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_event.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/auth/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final RegisterWithEmailAndPasswordUseCase
      _registerWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final LogoutUseCase _logoutUseCase;
  final SignInWithPhoneNumberUseCase _signInWithPhoneNumberUseCase;
  final VerificationEmailUseCase _verificationEmailUseCase;
  final GetUserUseCase _getUserUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  AuthBloc(
    this._logoutUseCase,
    this._signInWithPhoneNumberUseCase,
    this._loginWithEmailAndPasswordUseCase,
    this._registerWithEmailAndPasswordUseCase,
    this._signInWithGoogleUseCase,
    this._verificationEmailUseCase,
    this._getUserUseCase,
    this._uploadImageUseCase,
  ) : super(AuthLoading()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoading());

      final result = await _loginWithEmailAndPasswordUseCase.call(
        event.email,
        event.password,
      );
      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        print(result.error?.response?.data["message"]);
        emit(AuthFailure(result.error!));
      }
    });

    on<RegisterWithEmailAndPasswordEvent>((event, emit) async {
      final registrationResult =
          await _registerWithEmailAndPasswordUseCase.call(
        event.email,
        event.password,
        event.otp,
      );

      if (registrationResult is DataSuccess) {
        emit(VerifiedState());
      } else if (registrationResult is DataFailed) {
        print(registrationResult.error?.response?.data["message"]);
        emit(VerifiedFailState(registrationResult.error!));
      }
    });

    on<VerificationEmailEvent>((event, emit) async {
      final verificationResult =
          await _verificationEmailUseCase.call(event.email);
      if (verificationResult is DataSuccess) {
        emit(VerifyInProgressState());
      } else if (verificationResult is DataFailed) {
        print(verificationResult.error?.response?.data["message"]);
        emit(VerifiedFailState(verificationResult.error!));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await FirebaseAuth.instance.signInWithCredential(authCredential);
        FirebaseAuth fAuth = FirebaseAuth.instance;
        final User? firebaseUser =
            (await fAuth.signInWithCredential(authCredential).catchError((msg) {
          throw msg;
        }))
                .user;
        if (firebaseUser != null) {
          String? accessToken = await firebaseUser.getIdToken();
          const secureStorage = FlutterSecureStorage();
          await secureStorage.delete(key: 'access_token');
          print("token gg:======== $accessToken");
          final result = await _signInWithGoogleUseCase.call(accessToken ?? "");
          if (result is DataSuccess<AuthUser>) {
            emit(AuthSuccess(result.data!));
          } else if (result is DataFailed) {
            emit(AuthFailure(result.error!));
          }
        }
      }
    });

    on<CheckUserLoginEvent>((event, emit) async {
      const secureStorage = FlutterSecureStorage();
      String? accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        emit(AuthLoggedOut());
      } else {
        final result = await _getUserUseCase.call();
        if (result is DataSuccess<AuthUser>) {
          emit(AuthSuccess(result.data!));
        } else if (result is DataFailed) {
          emit(AuthLoggedOut());
          await secureStorage.delete(key: 'access_token');
          await secureStorage.delete(key: 'refresh_token');
        }
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      const secureStorage = FlutterSecureStorage();
      await secureStorage.delete(key: 'access_token');
      await secureStorage.delete(key: 'refresh_token');
      final result = await _logoutUseCase.call();
      if (result is DataSuccess) {
        emit(AuthLoggedOut());
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!));
      }
    });

    on<LoginWithPhoneNumberEvent>((event, emit) async {
      emit(AuthLoading());

      final result =
          await _signInWithPhoneNumberUseCase.call(event.phoneNumber);

      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!));
      }
    });

    on<UploadImageEvent>((event, emit) async {
      final dataState = await _uploadImageUseCase.call(event.file);

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        // emit(UserUploadSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        // emit(RemoteTourTagError(dataState.error!));
      }
    });
  }
}
