import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
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
    return _remoteDataSource.getAllTours();
  }

  @override
  Future<DataState<List<TourTag>>> getAllTags() {
    return _remoteDataSource.getAllTags();
  }

  @override
  Future<DataState<List<TourVehicle>>> getAllVehicles() {
    return _remoteDataSource.getAllVehicles();
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
