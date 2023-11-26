import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/datasources/remote/tour_api_service.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
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
  Future<DataState<List<TourEntity>>> getAllTours(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    return await _tourApiService.getAllTours(
        page: page,
        limit: limit,
        search: search,
        orderBy: orderBy,
        tagIds: tagIds);
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
  Future<DataState<List<TourReviewEntity>>> getReviews(String tourId) async {
    return await _tourApiService.getReviews(tourId);
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
  Future<DataState<List<ProvinceEntity>>> getAllProvinces() async {
    return await _tourApiService.getAllProvinces();
  }

  @override
  Future<DataState<List<TourEntity>>> getAllToursRcmTag(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    return await _tourApiService.getAllToursRcmTag(
        page: page,
        limit: limit,
        search: search,
        orderBy: orderBy,
        tagIds: tagIds);
  }

  @override
  Future<DataState<List<TourEntity>>> getAllToursRcmLocation(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    return await _tourApiService.getAllToursRcmLocation(
        page: page,
        limit: limit,
        search: search,
        orderBy: orderBy,
        tagIds: tagIds);
  }

  @override
  Future<DataState<List<TourEntity>>> getAllToursRcmSearch(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    return await _tourApiService.getAllToursRcmSearch(
        page: page,
        limit: limit,
        search: search,
        orderBy: orderBy,
        tagIds: tagIds);
  }

  @override
  Future<DataState<List<dynamic>>> getPopularLocation() async {
    return await _tourApiService.getPopularLocation();
  }

  @override
  Future<DataState> analyticLocation(Set<String> locations) async {
    return await _tourApiService.analyticLocation(locations);
  }

  @override
  Future<DataState> analyticTag(Set<int> tags) async {
    return await _tourApiService.analyticTag(tags);
  }
}
