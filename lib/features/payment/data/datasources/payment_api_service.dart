import 'package:dio/dio.dart';
import 'package:zest_trip/config/network/dio_helper.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';

abstract class PaymentApiService {
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date);
  Future<DataState<dynamic>> creatBooking(
      String name,
      String phone,
      String email,
      int adult,
      int children,
      DateTime date,
      String tourId,
      String redirectUrl);
}

class PaymentApiServiceImpl implements PaymentApiService {
  @override
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date) async {
    try {
      final params = {
        "adult": adult.toString(),
        "children": children.toString(),
        "date": date.toUtc().millisecondsSinceEpoch.toString(),
      };
      final response = await DioHelper.dio
          .get('/booking/bookingCheck/$tourId', queryParameters: params);
      print("response check :$response ");
      if (response.statusCode == 200) {
        return DataSuccess(response);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<dynamic>> creatBooking(
      String name,
      String phone,
      String email,
      int adult,
      int children,
      DateTime date,
      String tourId,
      String redirectUrl) async {
    try {
      final data = {
        "booker_name": name,
        "booker_phone": phone,
        "booker_email": email,
        "book_ticket": {
          "adult": adult,
          "children": children,
        },
        "selected_date": date.toString(),
        "tour_id": tourId,
        "redirectUrl": "https://google.com"
      };
      print("data create: $data");
      final response =
          await DioHelper.dio.post('/booking/bookTour', data: data);
      print("response check :${response.data} ");
      if (response.statusCode == 201) {
        return DataSuccess(response.data["data"]["transaction"]);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
