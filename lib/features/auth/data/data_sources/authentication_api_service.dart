import 'package:dio/dio.dart';
import 'package:zest_trip/core/network/dio_helper.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/data/models/auth_user_model.dart';

abstract class AuthApiService {
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password);
  Future<DataState<AuthUserModel>> registerWithEmailAndPassword(String email,
      String password, String fullName, String phone, String gender);
  Future<DataState<AuthUserModel>> signInWithGoogle(String accessToken);
  Future<DataState<void>> logout();
}

class AuthApiServiceImpl implements AuthApiService {
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
      final response = await DioHelper.post('/auth/login', data: data);
      final user = AuthUserModel.fromJson(response.data);
      return DataSuccess(user);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthUserModel>> registerWithEmailAndPassword(String email,
      String password, String fullName, String phone, String gender) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'full_name': fullName,
        'phone': phone,
        'gender': gender,
      };

      final response = await DioHelper.post('/auth/register', data: data);
      final user = AuthUserModel.fromJson(response.data);
      return DataSuccess(user);
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
      final user = AuthUserModel.fromJson(response.data);
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
