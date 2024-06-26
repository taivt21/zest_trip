import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/entities/district_entity.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';

abstract class TourRepository {
  Future<DataState<List<TourEntity>>> getAllTours({
    String? search,
    int? page,
    int? limit,
    String? orderBy,
    Set<int>? tagIds,
    Set<int>? vehicleIds,
    String? province,
    String? district,
    int? lowPrice,
    int? highPrice,
  });
  Future<DataState<List<TourEntity>>> getAllTourProvider(
    String providerId, {
    String? search,
    int? page,
    int? limit,
    String? orderBy,
    Set<int>? tagIds,
    Set<int>? vehicleIds,
  });
  Future<DataState<List<TourEntity>>> getAllToursRcmTag(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourEntity>>> getAllToursRcmLocation(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourEntity>>> getAllToursRcmSearch(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourEntity>>> getAllToursSponsore();
  Future<DataState<String>> getBanner();
  Future<DataState<List<TourEntity>>> getAllWishlist();
  Future<DataState<TourEntity>> getTourDetail(String tourId);
  Future<DataState<List<dynamic>>> getPopularLocation();
  Future<DataState<List<dynamic>>> getPopularTag();
  Future<DataState<dynamic>> analyticTag(Set<int> tags);
  Future<DataState<dynamic>> analyticLocation(Set<String> locations);

  Future<DataState<List<TourReviewEntity>>> getReviews(String tourId);
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();
  Future<DataState<List<ProvinceEntity>>> getAllProvinces();
  Future<DataState<List<DistrictEntity>>> getAllDistricts();
  Future<DataState<bool>> addToWishlist(String tourId);
  Future<DataState<bool>> removeFromWishlist(String tourId);
  Future<DataState<bool>> addToCart(String tourId);
  Future<DataState<bool>> removeFromCart(String tourId);
  Future<DataState<bool>> reportProvider(
      String providerId, String reason, String type);
}
