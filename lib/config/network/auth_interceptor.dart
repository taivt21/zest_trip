import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zest_trip/config/network/dio_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Lấy access_token từ bộ nhớ của ứng dụng
    String? accessToken = await getAccessToken();

    // Kiểm tra xem access_token có hết hạn hay không
    if (accessToken == null
        //  || isAccessTokenExpired(accessToken)
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
            await saveAccessTokenExpiration(response.data["expires_in"]);
            // Cập nhật access_token mới vào tiêu đề yêu cầu
            options.headers['Authorization'] =
                "Bearer ${response.data["access_token"]}";
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

  // TODO: Thêm các hàm kiểm tra và xử lý token tại đây

  Future<bool> isAccessTokenExpired(String accessToken) {
    // Kiểm tra xem access token đã hết hạn hay chưa
    // Đưa ra logic dựa trên thời gian hết hạn của token và thời gian hiện tại, ví dụ:
    // DateTime expirationTime = ...
    // return DateTime.now().isAfter(expirationTime);
    return Future.value(false);
  }

  Future<String?> getAccessToken() async {
    // Lấy access token từ bộ nhớ của ứng dụng
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    // Lấy refresh token từ bộ nhớ của ứng dụng
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  Future<void> saveAccessToken(String accessToken) async {
    // Lưu access token vào bộ nhớ của ứng dụng
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<void> saveAccessTokenExpiration(int expiresIn) async {
    // Cập nhật thời gian hết hạn mới cho access token vào bộ nhớ của ứng dụng
    DateTime newExpirationTime =
        DateTime.now().add(Duration(seconds: expiresIn));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'accessTokenExpiration', newExpirationTime.toIso8601String());
  }

  void handleRefreshTokenError() {
    // Xử lý khi gặp lỗi refresh token, ví dụ đăng xuất người dùng
    // ...
  }
}
