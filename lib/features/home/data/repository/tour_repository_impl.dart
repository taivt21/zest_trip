import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/models/tour_model.dart';
import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';

class TourRepositoryImpl implements TourRepository {
  final TourApiService _tourApiDataSource;
  TourRepositoryImpl(this._tourApiDataSource);

  @override
  Future<DataState<List<TourModel>>> getAllTours() async {
    return await _tourApiDataSource.getAllTours();
  }

  @override
  Future<DataState<TourModel>> getTours(String id) async {
    return await _tourApiDataSource.getTours(id);
  }
}
