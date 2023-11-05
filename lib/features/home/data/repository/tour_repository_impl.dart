import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class TourRepositoryImpl implements TourRepository {
  final TourApiService _tourApiService;

  TourRepositoryImpl(this._tourApiService);

  @override
  Future<DataState<bool>> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> addToWishlist(String tourId) async {
    return await _tourApiService.addToWishlist(tourId);
  }

  @override
  Future<DataState<List<TourEntity>>> getAllTours() async {
    return await _tourApiService.getAllTours();
  }

  @override
  Future<DataState<List<TourTag>>> getAllTags() async {
    return await _tourApiService.getAllTags();
  }

  @override
  Future<DataState<List<TourVehicle>>> getAllVehicles() async {
    return await _tourApiService.getAllVehicles();
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
    return await _tourApiService.postReview(content, rating, tourId);
  }

  @override
  Future<DataState<List<TourReviewEntity>>> getReviews(String tourId) async {
    return await _tourApiService.getReviews(tourId);
  }
}
