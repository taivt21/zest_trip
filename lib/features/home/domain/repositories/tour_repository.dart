import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class TourRepository {
  Future<DataState<List<TourEntity>>> getAllTours();
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();
  Future<DataState<bool>> postReview(String content, int rating, String tourId);
  Future<DataState<bool>> addToWishlist(String tourId);
  Future<DataState<bool>> removeFromWishlist(String tourId);
  Future<DataState<bool>> addToCart(String tourId);
  Future<DataState<bool>> removeFromCart(String tourId);
}
