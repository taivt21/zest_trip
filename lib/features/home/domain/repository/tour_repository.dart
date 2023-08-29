import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class TourRepository {
  Future<DataState<List<TourEntity>>> getAllTours();
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();
  Future<DataState<void>> addToWishlist(String tourId);
  Future<DataState<void>> removeFromWishlist(String tourId);
  Future<DataState<void>> addToCart(String tourId);
  Future<DataState<void>> removeFromCart(String tourId);
}
