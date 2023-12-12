import 'package:dio/dio.dart';
import 'package:zest_trip/config/network/auth_interceptor.dart';
import 'package:zest_trip/config/utils/constants/url_constant.dart';

class DioHelper {
  static late Dio _dio;

  static Dio get dio {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
        // receiveTimeout: const Duration(seconds: 15),
        // connectTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    // Thêm interceptor để log thông tin request trước khi gửi
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     print("Request URL: ${options.uri}");
    //     print("Request Headers: ${options.headers}");
    //     print("Request Data: ${options.data}");
    //     return handler.next(options);
    //   },
    // ));

    // Thêm interceptor để log thông tin response sau khi nhận
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onResponse: (response, handler) {
    //     print("Response Data: ${response.data}");
    //     return handler.next(response);
    //   },
    // ));
    AuthInterceptor authInterceptor = AuthInterceptor();
    _dio.interceptors.add(authInterceptor);

    return _dio;
  }
}
