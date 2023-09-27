import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/config/network/dio_helper.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_model.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';

var logger = Logger();

abstract class TourApiService {
  Future<DataState<List<TourModel>>> getAllTours(
      {String? search, int? page, int? limit, String? orderBy});
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();

  Future<DataState<bool>> addToWishlist(String tourId);
  Future<DataState<bool>> removeFromWishlist(String tourId);
  Future<DataState<bool>> addToCart(String tourId);
  Future<DataState<bool>> removeFromCart(String tourId);
}

class TourApiServiceIml implements TourApiService {
  @override
  Future<DataState<List<TourModel>>> getAllTours(
      {String? search, int? page, int? limit, String? orderBy}) async {
    // final params = {
    //   'search': search ?? "",
    //   'page': page ?? "",
    //   'limit': limit ?? "",
    //   'orderBy': orderBy ?? "",
    // };
    try {
      final response = await DioHelper.get('/tour');
      final tours = (response.data['data'] as List)
          .map((e) => TourModel.fromJson(e))
          .toList();
      print("call api tour: $tours");
      return DataSuccess(tours);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourTag>>> getAllTags() async {
    try {
      final response = await DioHelper.get('/resource/tag');
      final tags = (response.data['data'] as List)
          .map((e) => TourTag.fromJson(e))
          .toList();
      print("call api tags: $tags");
      return DataSuccess(tags);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourVehicle>>> getAllVehicles() async {
    try {
      final response = await DioHelper.get('/resource/vehicle');
      final vehicles = (response.data['data'] as List)
          .map((e) => TourVehicle.fromJson(e))
          .toList();
      print("call api vehicles: $vehicles");
      return DataSuccess(vehicles);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> addToWishlist(String tourId) async {
    try {
      final data = {'tourId': tourId};
      final res = await DioHelper.post('/favorite', data: data);
      if (res.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${res.statusCode}.',
          requestOptions: res.requestOptions,
          response: res,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> removeFromCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> removeFromWishlist(String tourId) {
    throw UnimplementedError();
  }
}
