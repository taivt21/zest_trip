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
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    AuthInterceptor authInterceptor = AuthInterceptor();
    _dio.interceptors.add(authInterceptor);

    return _dio;
  }
}
