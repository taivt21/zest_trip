import 'package:dio/dio.dart';
import 'package:zest_trip/config/network/dio_helper.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/authentication/data/models/auth_user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

abstract class AuthApiService {
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password);
  Future<DataState<bool>> registerWithEmailAndPassword(
      String email, String password, String otp);
  Future<DataState<bool>> verificationEmail(String email);
  Future<DataState<AuthUserModel>> signInWithGoogle(String accessToken);
  Future<DataState<void>> logout();
}

class AuthApiServiceImpl implements AuthApiService {
  final secureStorage = const FlutterSecureStorage();
  @override
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password) async {
    // Đặt accessToken vào header Authorization nếu cần
    // DioHelper.setAccessToken(accessToken);
    final data = {
      'email': email,
      'password': password,
    };
    try {
      final response = await DioHelper.post('/auth/signin', data: data);
      final accessToken = response.data['data']['access_token'];
      final refreshToken = response.data['data']['refresh_token'];

      await secureStorage.write(key: 'access_token', value: accessToken);
      await secureStorage.write(key: 'refresh_token', value: refreshToken);

      Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
      final user = AuthUserModel.fromJson(payload);
      return DataSuccess(user);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> registerWithEmailAndPassword(
      String email, String password, String otp) async {
    try {
      final data = {'email': email, 'password': password, 'otp': otp};

      final response = await DioHelper.post('/auth/signup', data: data);
      if (response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> verificationEmail(String email) async {
    try {
      final data = {
        'email': email,
      };
      final response = await DioHelper.post('/auth/verification', data: data);
      if (response.statusCode == 200) {
        return DataSuccess(true);
      }
      return DataFailed(DioException(
        type: DioExceptionType.badResponse,
        message: 'The request returned an '
            'invalid status code of ${response.statusCode}.',
        requestOptions: response.requestOptions,
        response: response,
      ));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthUserModel>> signInWithGoogle(String accessToken) async {
    final data = {
      'accessToken': accessToken,
    };

    try {
      final response = await DioHelper.post('/auth/google-login', data: data);
      final accessToken = response.data['data']['access_token'];
      final refreshToken = response.data['data']['refresh_token'];

      await secureStorage.write(key: 'access_token', value: accessToken);
      await secureStorage.write(key: 'refresh_token', value: refreshToken);
      Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
      final user = AuthUserModel.fromJson(payload);
      return DataSuccess(user);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      // Gọi API đăng xuất tại đây
      final response = await DioHelper.post('/auth/logout');

      // Kiểm tra mã trạng thái của response để xác định xem đăng xuất thành công hay không
      if (response.statusCode == 200) {
        // Nếu thành công, trả về DataSuccess<void> (không có dữ liệu)
        return DataSuccess<void>(null);
      } else {
        // Nếu không thành công, trả về DataFailed với thông báo lỗi từ response
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Logout failed with status code: ${response.statusCode}',
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      // Nếu xảy ra lỗi trong quá trình gọi API, trả về DataFailed với thông báo lỗi từ DioException
      return DataFailed(e);
    }
  }
}
