import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';

class TourRepositoryImpl implements TourRepository {
  final TourRemoteDataSource _remoteDataSource;

  TourRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<void>> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> addToWishlist(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<TourEntity>>> getAllTours() {
    return _remoteDataSource.fetchTours();
  }

  @override
  Future<DataState<void>> removeFromCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> removeFromWishlist(String tourId) {
    throw UnimplementedError();
  }
}
