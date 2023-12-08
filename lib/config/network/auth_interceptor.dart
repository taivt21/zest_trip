import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:zest_trip/config/utils/constants/url_constant.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await getAccessToken();
    print("accessToken $accessToken");
    if (options.path == '/tour') {
      return handler.next(options);
    }
    // if (accessToken == null) {
    //   return handler.next(options);
    // }
    // if (await isAccessTokenValid(accessToken)) {
    //   options.headers['Authorization'] = "Bearer $accessToken";
    //   return handler.next(options);
    // }

    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
      return handler.next(options);
    }

    // try {
    //   final newAccessToken = await refreshAccessToken();
    //   if (newAccessToken != null) {
    //     options.headers['Authorization'] = "Bearer $newAccessToken";
    //     return handler.next(options);
    //   }
    // } on DioException catch (error) {
    //   return handler.reject(error, true);
    // }

    return handler.next(options);
  }

  Future<bool> isAccessTokenValid(String accessToken) async {
    final expirationTime = Jwt.getExpiryDate(accessToken);
    return expirationTime != null && DateTime.now().isBefore(expirationTime);
  }

  Future<String?> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      return null;
    }

    try {
      final response = await _dio.post(
        '${Constants.baseUrl}/auth/refresh',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $refreshToken"
        }),
      );

      if (response.statusCode == 201) {
        final newAccessToken = response.data["data"]["access_token"];
        final newRefreshToken = response.data["data"]["refresh_token"];
        await saveAccessToken(newAccessToken);
        await saveRefreshToken(newRefreshToken);
        return newAccessToken;
      }
    } on DioException catch (error) {
      return error.message;
    }

    return null;
  }

  // Future<bool> isAccessTokenExpired(String accessToken) async {
  //   Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
  //   final expirationTimeInSeconds = payload['exp'];
  //   if (expirationTimeInSeconds != null) {
  //     final expirationTime =
  //         DateTime.fromMillisecondsSinceEpoch(expirationTimeInSeconds * 1000);
  //     return DateTime.now().isAfter(expirationTime);
  //   }
  //   return true;
  // }

  Future<void> deleteAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.delete(key: 'access_token');
  }

  Future<void> deteleRefreshToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.delete(key: 'refresh_token');
  }

  Future<String?> getAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'refresh_token');
  }

  Future<void> saveAccessToken(String accessToken) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'access_token', value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'refresh_token', value: refreshToken);
  }
}
