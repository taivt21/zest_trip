import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/config/network/dio_helper.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_model.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';

var logger = Logger();

abstract class TourRemoteDataSource {
  Future<DataState<List<TourModel>>> getAllTours(
      {String? search, int? page, int? limit, String? orderBy});
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();

  Future<void> addToWishlist(String tourId);
  Future<void> removeFromWishlist(String tourId);
  Future<void> addToCart(String tourId);
  Future<void> removeFromCart(String tourId);
}

class TourRemoteDataSourceIml implements TourRemoteDataSource {
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
      // logger.i('res...............${response.data['data']['tag_id']}');
      final tours = (response.data['data'] as List)
          .map((e) => TourModel.fromJson(e))
          .toList();
      print(tours);
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
      print(tags);
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
      print(vehicles);
      return DataSuccess(vehicles);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<void> addToWishlist(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromWishlist(String tourId) {
    throw UnimplementedError();
  }
}
