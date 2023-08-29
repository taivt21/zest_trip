import 'package:dio/dio.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';
import 'package:zest_trip/features/authentication/domain/repositories/auth_repository.dart';

class LoginWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  LoginWithEmailAndPasswordUseCase(this._authRepository);

  Future<DataState<AuthUser>> call(String email, String password) {
    // Gọi phương thức đăng nhập từ repository để lấy dữ liệu
    return _authRepository.loginWithEmailAndPassword(email, password);
  }
}

class RegisterWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  RegisterWithEmailAndPasswordUseCase(this._authRepository);

  Future<DataState<bool>> call(String email, String password,
      ) {
    // Gọi phương thức đăng ký từ repository để lấy dữ liệu
    return _authRepository.registerWithEmailAndPassword(
        email, password);
  }
}

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<DataState<AuthUser>> call(String accessToken) async {
    try {
      // Gọi phương thức signInWithGoogle từ repository
      final result = await _authRepository.signInWithGoogle(accessToken);
      return result;
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<DataState<void>> call() async {
    try {
      // Gọi phương thức logout từ repository
      await _authRepository.logout();
      return DataSuccess<void>(null);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

class SignInWithPhoneNumberUseCase {
  final AuthRepository _authRepository;

  SignInWithPhoneNumberUseCase(this._authRepository);

  Future<DataState<AuthUser>> call(String phoneNumber) {
    // Call the phone number login method from the repository
    return _authRepository.signInWithPhoneNumber(phoneNumber);
  }
}
