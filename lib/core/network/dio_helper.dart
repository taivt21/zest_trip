import 'package:dio/dio.dart';
import 'package:zest_trip/core/constants/url_constant.dart';
import 'package:zest_trip/core/network/auth_interceptor.dart';

class DioHelper {
  static late Dio _dio;

  static Dio get dio {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    // Add your custom interceptors here
    _dio.interceptors.add(AuthInterceptor());

    return _dio;
  }

  // Add a method to set the accessToken to the Dio instance
  static void setAccessToken(String accessToken) {
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static DioException _handleError(DioException e) {
    //xử lý lỗi theo yêu cầu cụ thể ở đây
    return e;
  }
}
