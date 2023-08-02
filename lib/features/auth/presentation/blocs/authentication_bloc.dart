import 'package:bloc/bloc.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';
import 'package:zest_trip/features/auth/domain/usecases/authentication_usecase.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_event.dart';
import 'package:zest_trip/features/auth/presentation/blocs/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;
  final RegisterWithEmailAndPasswordUseCase registerWithEmailAndPasswordUseCase;
  final GoogleSignInUseCase signInWithGoogleUseCase;

  AuthBloc({
    required this.loginWithEmailAndPasswordUseCase,
    required this.registerWithEmailAndPasswordUseCase,
    required this.signInWithGoogleUseCase,
  }) : super(AuthInitial()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      // Xử lý đăng nhập bằng email và password
      emit(AuthLoading());
      final result = await loginWithEmailAndPasswordUseCase.call(
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
      // Xử lý đăng ký bằng email và password
      emit(AuthLoading());
      final result = await registerWithEmailAndPasswordUseCase.call(
        event.email,
        event.password,
        event.fullName,
        event.dob,
        event.gender,
      );
      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      // Xử lý đăng nhập bằng tài khoản Google
      emit(AuthLoading());
      final result = await signInWithGoogleUseCase.call();
      if (result is DataSuccess<AuthUser>) {
        emit(AuthSuccess(result.data!));
      } else if (result is DataFailed) {
        emit(AuthFailure(result.error!.message!));
      }
    });
  }
}
