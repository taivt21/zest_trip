import 'dart:io';

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
  Future<DataState<AuthUserModel>> getUser();
  Future<DataState<void>> logout();
  Future<DataState<bool>> uploadImage(File file);
}

class AuthApiServiceImpl implements AuthApiService {
  final secureStorage = const FlutterSecureStorage();
  @override
  Future<DataState<AuthUserModel>> loginWithEmailAndPassword(
      String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    try {
      final response =
          await DioHelper.dio.post('/auth/customer/signin', data: data);

      if (response.statusCode == 201) {
        final accessToken = response.data['data']['access_token'];
        final refreshToken = response.data['data']['refresh_token'];

        await secureStorage.write(key: 'access_token', value: accessToken);
        await secureStorage.write(key: 'refresh_token', value: refreshToken);

        Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
        final user = AuthUserModel.fromJson(payload);
        return DataSuccess(user);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: ' ${response.data["data"]["message"]}.',
          requestOptions: response.requestOptions,
          response: response.data["data"]["message"],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> registerWithEmailAndPassword(
      String email, String password, String otp) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'otp': otp,
      };

      final response =
          await DioHelper.dio.post('/auth/customer/signup', data: data);
      print(response);
      if (response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data["data"]["message"],
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
        'type': "REGISTER_USER",
      };
      final response =
          await DioHelper.dio.post('/otp/generate/customer', data: data);
      print("otp $response");
      if (response.statusCode == 201) {
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
      final response =
          await DioHelper.dio.post('/auth/customer/login-google', data: data);

      if (response.statusCode == 200) {
        final accessToken = response.data['data']['access_token'];
        final refreshToken = response.data['data']['refresh_token'];

        await secureStorage.write(key: 'access_token', value: accessToken);
        await secureStorage.write(key: 'refresh_token', value: refreshToken);
        Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
        final user = AuthUserModel.fromJson(payload);
        return DataSuccess(user);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          message: "mess: ${response.data["message"]}",
          response: response,
          error: 'Failed with status code: ${response.data["message"]}',
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      final response = await DioHelper.dio.post('/auth/customer/signout');

      if (response.statusCode == 204) {
        return DataSuccess(null);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response.data,
          error: 'Logout failed with status code: ${response.statusCode}',
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AuthUserModel>> getUser() async {
    try {
      final response = await DioHelper.dio.get(
        '/users/me',
      );
      print("me: ${response.data}");

      if (response.statusCode == 200) {
        final user = AuthUserModel.fromJson(response.data);

        return DataSuccess(user);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response.data,
          message: response.data["message"],
          error: 'Failed with status code: ${response.statusCode}',
          type: DioExceptionType.badResponse,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> uploadImage(File file) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      final response =
          await DioHelper.dio.put('/users/me/avatar', data: formData);

      if (response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
