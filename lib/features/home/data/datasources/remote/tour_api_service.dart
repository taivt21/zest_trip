import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zest_trip/core/network/dio_helper.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_model.dart';

var logger = Logger();

abstract class TourRemoteDataSource {
  Future<DataState<List<TourModel>>> fetchTours(
      {String? search, int? page, int? limit, String? orderBy});
  Future<void> addToWishlist(String tourId);
  Future<void> removeFromWishlist(String tourId);
  Future<void> addToCart(String tourId);
  Future<void> removeFromCart(String tourId);
}

class TourRemoteDataSourceIml implements TourRemoteDataSource {
  @override
  Future<void> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<void> addToWishlist(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<TourModel>>> fetchTours(
      {String? search, int? page, int? limit, String? orderBy}) async {
    // final params = {
    //   'search': search ?? "",
    //   'page': page ?? "",
    //   'limit': limit ?? "",
    //   'orderBy': orderBy ?? "",
    // };
    try {
      final response = await DioHelper.get('/tour');
      logger.i('res...............${response.data['data']['tag_id']}');
      final tours = (response.data['data'] as List)
          .map((e) => TourModel.fromJson(e))
          .toList();
      logger.i('tours...............$tours');
      return DataSuccess(tours);
    } on DioException catch (e) {
      return DataFailed(e);
    }
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
