import 'package:dio/dio.dart';
import 'package:zest_trip/core/network/dio_helper.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/auth/data/models/auth_user_model.dart';

class AuthApiService {
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password) async {
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

  Future<DataState<AuthUserModel>> registerWithEmailAndPassword(String email,
      String password, String fullName, String dob, String gender) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'full_name': fullName,
        'dob': dob,
        'gender': gender,
      };

      final response = await DioHelper.post('/auth/register', data: data);
      final user = AuthUserModel.fromJson(response.data);
      return DataSuccess(user);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

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
}
