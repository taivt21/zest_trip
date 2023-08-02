import 'package:dio/dio.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/domain/entities/auth_user.dart';
import 'package:zest_trip/features/auth/domain/repositories/auth_repository.dart';

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

  Future<DataState<AuthUser>> call(String email, String password,
      String fullName, String dob, String gender) {
    // Gọi phương thức đăng ký từ repository để lấy dữ liệu
    return _authRepository.registerWithEmailAndPassword(
        email, password, fullName, dob, gender);
  }
}

class GoogleSignInUseCase {
  final AuthRepository _authRepository;

  GoogleSignInUseCase(this._authRepository);

  Future<DataState<AuthUser>> call() async {
    try {
      // Gọi phương thức signInWithGoogle từ repository
      final result = await _authRepository.signInWithGoogle();
      return result;
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
