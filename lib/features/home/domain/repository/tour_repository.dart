import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class TourRepository {
  Future<DataState<List<TourEntity>>> getAllTours();
  Future<DataState<void>> addToWishlist(String tourId);
  Future<DataState<void>> removeFromWishlist(String tourId);
  Future<DataState<void>> addToCart(String tourId);
  Future<DataState<void>> removeFromCart(String tourId);
}
