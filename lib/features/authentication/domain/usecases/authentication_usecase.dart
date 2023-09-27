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

  Future<DataState<bool>> call(
    String email,
    String password,
    String otp,
  ) {
    final result =
        _authRepository.registerWithEmailAndPassword(email, password, otp);
    // Gọi phương thức đăng ký từ repository để lấy dữ liệu
    return result;
  }
}

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<DataState<AuthUser>> call(String accessToken) async {
    try {
      return await _authRepository.signInWithGoogle(accessToken);
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

  Future<DataState<AuthUser>> call(String phoneNumber) async {
    // Call the phone number login method from the repository
    return await _authRepository.signInWithPhoneNumber(phoneNumber);
  }
}

class VerificationEmailUseCase {
  final AuthRepository _authRepository;

  VerificationEmailUseCase(this._authRepository);

  Future<DataState<bool>> call(String email) async {
    return await _authRepository.verificationEmail(email);
  }
}

class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  Future<DataState<AuthUser>> call() async {
    return await _authRepository.getUser();
  }
}
