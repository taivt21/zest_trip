import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';
import 'package:zest_trip/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_event.dart';
import 'package:zest_trip/features/authentication/presentation/blocs/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final RegisterWithEmailAndPasswordUseCase
      _registerWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final LogoutUseCase _logoutUseCase;
  final SignInWithPhoneNumberUseCase _signInWithPhoneNumberUseCase;

  AuthBloc(
    this._logoutUseCase,
    this._signInWithPhoneNumberUseCase,
    this._loginWithEmailAndPasswordUseCase,
    this._registerWithEmailAndPasswordUseCase,
    this._signInWithGoogleUseCase,
  ) : super(AuthInitial()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      // Xử lý đăng nhập bằng email và password
      emit(AuthLoading());
      final result = await _loginWithEmailAndPasswordUseCase.call(
        event.email,
        event.password,
      );
      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });

    on<RegisterWithEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _registerWithEmailAndPasswordUseCase.call(
        event.email,
        event.password,
      );
      if (result is DataSuccess<bool>) {
        if (result.data == true) {
          emit(RegisterSuccess());
        }
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      // Xử lý đăng nhập bằng tài khoản Google
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
          final result = await _signInWithGoogleUseCase.call(accessToken ?? "");
          if (result is DataSuccess<AuthUser>) {
            emit(AuthSuccess(result.data!));
          } else if (result is DataFailed) {
            emit(AuthFailure(result.error!.message!));
          }
        }
      }
    });

    // Xử lý sự kiện logout
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _logoutUseCase.call();
      if (result is DataSuccess) {
        emit(AuthLoggedOut());
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });

    on<LoginWithPhoneNumberEvent>((event, emit) async {
      emit(AuthLoading());

      final result =
          await _signInWithPhoneNumberUseCase.call(event.phoneNumber);

      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });
  }
}
