import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../../../config/network/dio_helper.dart';
import '../../../../../../config/utils/resources/data_state.dart';
import '../../../../../../features/home/data/models/tour_model.dart';
import '../../../../../../features/home/data/models/tour_tag.dart';
import '../../../../../../features/home/data/models/tour_vehicle.dart';

abstract class TourApiService {
  Future<DataState<List<TourModel>>> getAllTours(
      {String? search, int? page, int? limit, String? orderBy});
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();

  Future<DataState<bool>> postReview(String content, int rating, String tourId);
  Future<DataState<bool>> addToWishlist(String tourId);
  Future<DataState<bool>> removeFromWishlist(String tourId);
  Future<DataState<bool>> addToCart(String tourId);
  Future<DataState<bool>> removeFromCart(String tourId);
}

class TourApiServiceImpl implements TourApiService {
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
      final response = await DioHelper.dio.get('/tour');
      final tours = (response.data['data'] as List)
          .map((e) => TourModel.fromJson(e))
          .toList();
      print("call api tour: $tours");
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourTag>>> getAllTags() async {
    try {
      final response = await DioHelper.dio.get('/resource/tag');
      final tags = (response.data['data'] as List)
          .map((e) => TourTag.fromJson(e))
          .toList();
      log("call api tags: $tags");
      if (response.statusCode == 200) {
        return DataSuccess(tags);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourVehicle>>> getAllVehicles() async {
    try {
      final response = await DioHelper.dio.get('/resource/vehicle');
      final vehicles = (response.data['data'] as List)
          .map((e) => TourVehicle.fromJson(e))
          .toList();
      print("call api vehicles: $vehicles");
      if (response.statusCode == 200) {
        return DataSuccess(vehicles);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
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
      final response = await DioHelper.dio.post('/favorite', data: data);
      if (response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
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

  @override
  Future<DataState<bool>> postReview(
      String content, int rating, String tourId) async {
    try {
      final data = {'content': content, 'rating': rating};
      final param = {'tourId': "1a5607a8-9a70-4731-be02-30df4c1c1676"};

      final response = await DioHelper.dio
          .post('/review', data: data, queryParameters: param);
      print(response.data);
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
}
