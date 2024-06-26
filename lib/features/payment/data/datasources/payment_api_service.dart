import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:zest_trip/config/network/dio_helper.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/provider_model.dart';
import 'package:zest_trip/features/home/data/models/tour_review_model.dart';
import 'package:zest_trip/features/payment/data/models/invoice_model.dart';
import 'package:zest_trip/features/payment/data/models/tour_check_booking_model.dart';
import 'package:zest_trip/features/payment/data/models/tour_voucher_model.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';

abstract class PaymentApiService {
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date);
  Future<DataState<dynamic>> creatBooking(BookingEntity bookingModel,
      String redirectUrl, int voucherId, String location);
  Future<DataState<dynamic>> requestRefund(String bookingId, String reason);
  Future<DataState<bool>> postReview(String content, int rating, String tourId);

  Future<DataState<List<InvoiceModel>>> getOwnBooking(String userId);
  Future<DataState<List<TourReviewModel>>> getOwnReview();
  Future<DataState<List<TourVoucherModel>>> getVoucher(String tourId);
  Future<DataState<ProviderModel>> getInfoProvider(String providerId);
  Future<DataState<TourCheckBookingModel>> getCheckingTour(String tourId);
}

class PaymentApiServiceImpl implements PaymentApiService {
  @override
  Future<DataState<dynamic>> checkAvailable(
      tourId, adult, children, date) async {
    try {
      final data = {
        "adult": adult,
        "children": children,
        "date": DateFormat('yyyy-MM-dd').format(date),
      };
      print("data check booking $data");
      final response =
          await DioHelper.dio.post('/booking/bookingCheck/$tourId', data: data);
      if (response.statusCode == 200) {
        // print("check: ${response.data["data"]}");
        return DataSuccess(response.data["data"]["data"]);
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
      bookingModel, redirectUrl, voucherId, location) async {
    try {
      final Map<String, dynamic> data = {
        "booker_name": bookingModel.bookerName,
        "booker_phone": bookingModel.bookerPhone,
        "booker_email": bookingModel.bookerEmail,
        "book_ticket": {
          "adult": bookingModel.adult,
          "children": bookingModel.children,
        },
        "selected_date": DateFormat('yyyy-MM-dd')
            .format(bookingModel.selectedDate!)
            .toString(),
        "tour_id": bookingModel.tourId,
        "redirectUrl": "https://google.com",
        "departure_location": location,
      };
      print("create booking: $data");
      if (voucherId != -1) {
        data["voucher_id"] = voucherId;
      }
      final response =
          await DioHelper.dio.post('/booking/bookTour', data: data);
      if (response.statusCode == 201) {
        return DataSuccess(response.data["data"]["transaction"]);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> postReview(content, rating, tourId) async {
    try {
      final data = {'content': content, 'rating': rating};

      final response = await DioHelper.dio.post('/review/$tourId', data: data);
      if (response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.data["data"]["message"]}.',
          requestOptions: response.requestOptions,
          response: response.data["data"]["message"],
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<InvoiceModel>>> getOwnBooking(userId) async {
    const secureStorage = FlutterSecureStorage();
    final accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken == null || accessToken.isEmpty) {
      return DataFailed(DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(),
      ));
    }
    Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
    final String userId = payload['id'] as String;
    try {
      final data = {
        "user_id": userId,
        "select": "100",
        "order_by": "created_at",
        "sort_by": "asc"
      };
      final response = await DioHelper.dio.post('/booking/owned', data: data);
      List<InvoiceModel> bookings = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        bookings = (response.data['data'] as List)
            .map((e) => InvoiceModel.fromJson(e))
            .toList();
      }

      if (response.statusCode == 200) {
        return DataSuccess(bookings);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ProviderModel>> getInfoProvider(providerId) async {
    try {
      final response = await DioHelper.dio.get(
        '/provider/detail/$providerId',
      );

      if (response.statusCode == 200) {
        final user = ProviderModel.fromJson(response.data["data"]);

        return DataSuccess(user);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response,
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
  Future<DataState<List<TourReviewModel>>> getOwnReview() async {
    const secureStorage = FlutterSecureStorage();
    final accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken == null || accessToken.isEmpty) {
      return DataFailed(DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(),
      ));
    }
    Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
    final String userId = payload['id'] as String;
    try {
      List<TourReviewModel> reviews = [];
      final response = await DioHelper.dio.get('/review/user/$userId');
      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        reviews = (response.data['data'] as List)
            .map((e) => TourReviewModel.fromJson(e))
            .toList();
      }

      if (response.statusCode == 200) {
        return DataSuccess(reviews);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<dynamic>> requestRefund(bookingId, reason) async {
    try {
      final data = {
        "booking_id": bookingId,
        "reason": reason,
      };
      final response =
          await DioHelper.dio.patch('/booking/refund/request', data: data);

      if (response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response,
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
  Future<DataState<List<TourVoucherModel>>> getVoucher(tourId) async {
    try {
      final query = {"tour": tourId};
      List<TourVoucherModel> vouchers = [];
      final response =
          await DioHelper.dio.get('/voucher', queryParameters: query);
      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        vouchers = (response.data['data'] as List)
            .map((e) => TourVoucherModel.fromJson(e))
            .toList();
      }

      if (response.statusCode == 200) {
        return DataSuccess(vouchers);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TourCheckBookingModel>> getCheckingTour(tourId) async {
    try {
      final response = await DioHelper.dio.get('/pricing/byTour/$tourId');

      final tourChecking =
          TourCheckBookingModel.fromJson(response.data["data"]);

      if (response.statusCode == 200) {
        return DataSuccess(tourChecking);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
