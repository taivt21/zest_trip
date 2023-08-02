
import 'package:dio/dio.dart';
import 'package:zest_trip/core/network/dio_helper.dart';
import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_model.dart';  

class TourApiService {
  Future<DataState<List<TourModel>>> getAllTours() async {
    try {
      final response = await DioHelper.get('/tours');
      final tours =
          (response.data as List).map((e) => TourModel.fromJson(e)).toList();
      return DataSuccess(tours);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<TourModel>> getTours(String id) async {
    try {
      final response = await DioHelper.get('/tours/$id');
      final tour = TourModel.fromJson(response.data);
      return DataSuccess(tour);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
