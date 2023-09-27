import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:zest_trip/config/utils/constants/url_constant.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await getAccessToken();
    print("access token:  $accessToken");

    if (accessToken == null) {
      return handler.next(options);
    } else if (await isAccessTokenExpired(accessToken)) {
      try {
        String? refreshToken = await getRefreshToken();
        print("refreshToken: $refreshToken");
        if (refreshToken != null) {
          final response = await _dio.post(
            '${Constants.baseUrl}/auth/refresh',
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Authorization': "Bearer $refreshToken"
            }),
          );
          if (response.statusCode == 200) {
            var newAccessToken = response.data["data"]["access_token"];
            await saveAccessToken(newAccessToken);
            options.headers['Authorization'] = "Bearer $newAccessToken";
          } else {
            // Xử lý khi lỗi trả về từ API refresh token
            handleRefreshTokenError();
          }
        } else {
          // Xử lý khi không có refresh_token (người dùng đã đăng xuất hoặc chưa đăng nhập)
          handleRefreshTokenError();
        }
      } on DioException catch (error) {
        // Xử lý khi gặp lỗi khi gửi yêu cầu refresh token
        handleRefreshTokenError();
        return handler.reject(error, true);
      }
    } else {
      options.headers['Authorization'] = "Bearer $accessToken";
    }

    handler.next(options);
  }

  Future<bool> isAccessTokenExpired(String accessToken) async {
    Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
    final expirationTimeInSeconds = payload['exp'];
    if (expirationTimeInSeconds != null) {
      final expirationTime =
          DateTime.fromMillisecondsSinceEpoch(expirationTimeInSeconds * 1000);
      return DateTime.now().isAfter(expirationTime);
    }
    return true;
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

  void handleRefreshTokenError() {
    // Xử lý khi gặp lỗi refresh token
  }
}
