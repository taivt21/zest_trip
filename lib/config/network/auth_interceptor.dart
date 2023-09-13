import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zest_trip/config/network/dio_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Lấy access_token từ bộ nhớ của ứng dụng
    String? accessToken = await getAccessToken();

    // Kiểm tra xem access_token có hết hạn hay không
    if (accessToken == null
        //  || isAccessTokenExpired(accessToken) == false
        ) {
      try {
        // Gửi yêu cầu lấy access_token mới sử dụng refresh_token
        String? refreshToken = await getRefreshToken();
        if (refreshToken != null) {
          final response = await DioHelper.post('/auth/refresh',
              data: {'refresh_token': refreshToken});
          if (response.statusCode == 200) {
            // Cập nhật access_token mới và thời gian hết hạn vào bộ nhớ của ứng dụng
            await saveAccessToken(response.data["access_token"]);
            await saveAccessTokenExpiration(response.data["exp"]);
            // Cập nhật access_token mới vào tiêu đề yêu cầu
            options.headers['Authorization'] =
                "Bearer ${response.data["accessToken"]}";
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
      // Gắn access_token vào header, gửi kèm access_token trong header mỗi khi call API
      options.headers['Authorization'] = "Bearer $accessToken";
    }

    handler.next(options);
  }

  Future<bool> isAccessTokenExpired(String accessToken) {
    // Kiểm tra xem access token đã hết hạn hay chưa
    // Đưa ra logic dựa trên thời gian hết hạn của token và thời gian hiện tại, ví dụ:
    // DateTime expirationTime = ...
    // return DateTime.now().isAfter(expirationTime);
    return Future.value(false);
  }

  Future<String?> getAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'refreshToken');
  }

  Future<void> saveAccessToken(String accessToken) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: 'accessToken', value: accessToken);
  }

  Future<void> saveAccessTokenExpiration(int expiresIn) async {
    const secureStorage = FlutterSecureStorage();
    DateTime newExpirationTime =
        DateTime.now().add(Duration(seconds: expiresIn));
    await secureStorage.write(
      key: 'accessTokenExpiration',
      value: newExpirationTime.toIso8601String(),
    );
  }

  void handleRefreshTokenError() {
    // Xử lý khi gặp lỗi refresh token, ví dụ đăng xuất người dùng
    // ...
  }
}
