import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:zest_trip/features/home/data/models/district_model.dart';
import 'package:zest_trip/features/home/data/models/province_model.dart';
import 'package:zest_trip/features/home/data/models/tour_review_model.dart';
import '../../../../../../config/network/dio_helper.dart';
import '../../../../../../config/utils/resources/data_state.dart';
import '../../../../../../features/home/data/models/tour_model.dart';
import '../../../../../../features/home/data/models/tour_tag.dart';
import '../../../../../../features/home/data/models/tour_vehicle.dart';

abstract class TourApiService {
  Future<DataState<List<TourModel>>> getAllTours({
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
  Future<DataState<List<TourModel>>> getAllTourProvider(
    String providerId, {
    String? search,
    int? page,
    int? limit,
    String? orderBy,
    Set<int>? tagIds,
    Set<int>? vehicleIds,
  });
  Future<DataState<List<TourModel>>> getAllToursRcmTag(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourModel>>> getAllToursRcmLocation(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourModel>>> getAllToursRcmSearch(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourModel>>> getAllToursSponsore(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds});
  Future<DataState<List<TourModel>>> getAllWishlist();
  Future<DataState<String>> getBanner();

  Future<DataState<TourModel>> getTourDetail(tourId);
  Future<DataState<dynamic>> analyticTag(Set<int> tags);
  Future<DataState<dynamic>> analyticLocation(Set<String> locations);
  Future<DataState<List<dynamic>>> getPopularLocation();

  Future<DataState<List<TourReviewModel>>> getReviews(String tourId);
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();
  Future<DataState<List<ProvinceModel>>> getAllProvinces();
  Future<DataState<List<DistrictModel>>> getAllDistricts();

  Future<DataState<bool>> reportProvider(
      String providerId, String reason, String type);
  Future<DataState<bool>> addToWishlist(String tourId);
  Future<DataState<bool>> removeFromWishlist(String tourId);
  Future<DataState<bool>> addToCart(String tourId);
  Future<DataState<bool>> removeFromCart(String tourId);
}

class TourApiServiceImpl implements TourApiService {
  @override
  Future<DataState<List<TourModel>>> getAllTours({
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
  }) async {
    List<int> tags = tagIds?.toList() ?? [];
    List<int> vehicles = vehicleIds?.toList() ?? [];
    final queries = {
      "page": page,
      "select": limit,
      "tag": tags,
      "vehicle": vehicles,
      if (province != null && province.isNotEmpty) "province": province,
      if (district != null && district.isNotEmpty) "district": district,
      if (search != null && search.isNotEmpty) "query": search,
      if (lowPrice != null && lowPrice != -1) "lower": lowPrice,
      if (highPrice != null && highPrice != -1) "higher": highPrice,
    };
    // print("query tour: $queries");
    try {
      final response =
          await DioHelper.dio.get('/tour/v2', queryParameters: queries);
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllTourProvider(
    String providerId, {
    String? search,
    int? page,
    int? limit,
    String? orderBy,
    Set<int>? tagIds,
    Set<int>? vehicleIds,
  }) async {
    List<int> tags = tagIds?.toList() ?? [];
    List<int> vehicles = vehicleIds?.toList() ?? [];
    final queries = {
      if (page != null) "page": page,
      if (limit != null) "select": limit,
      if (tags.isNotEmpty) "tag": tags,
      if (vehicles.isNotEmpty) "vehicle": vehicles,
      if (search != null && search.isNotEmpty) "query": search,
    };
    try {
      final response = await DioHelper.dio
          .get('/tour/provider/list/$providerId', queryParameters: queries);
      List<TourModel> tours = [];

      if (response.data['data']["tours"] != null &&
          (response.data['data']["tours"] as List).isNotEmpty) {
        tours = (response.data['data']["tours"] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourTag>>> getAllTags() async {
    try {
      final response = await DioHelper.dio.get('/resource/tag');
      final tags = (response.data['data'] as List)
          .map((e) => TourTag.fromJson(e))
          .toList();
      log("call api tags: $tags");
      if (response.statusCode == 200) {
        return DataSuccess(tags);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourVehicle>>> getAllVehicles() async {
    try {
      final response = await DioHelper.dio.get('/resource/vehicle');
      final vehicles = (response.data['data'] as List)
          .map((e) => TourVehicle.fromJson(e))
          .toList();
      if (response.statusCode == 200) {
        return DataSuccess(vehicles);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> addToCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> addToWishlist(String tourId) async {
    try {
      final data = {'tourId': tourId};
      final response = await DioHelper.dio.post('/users/favorites', data: data);
      if (response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> reportProvider(
      String providerId, String reason, String type) async {
    try {
      final data = {'description': reason, "reportType": type.toUpperCase()};
      print("data report: $data");
      final response =
          await DioHelper.dio.post('/report/provider/$providerId', data: data);
      if (response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> removeFromCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> removeFromWishlist(String tourId) async {
    try {
      final response = await DioHelper.dio.delete('/users/favorites/$tourId');
      if (response.statusCode == 204) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourReviewModel>>> getReviews(String tourId) async {
    try {
      final response = await DioHelper.dio.get('/review/tour/$tourId');
      final reviews = (response.data['data'] as List)
          .map((e) => TourReviewModel.fromJson(e))
          .toList();
      if (response.statusCode == 200) {
        return DataSuccess(reviews);
      } else {
        return DataFailed(DioException(
            type: DioExceptionType.badResponse,
            message: 'The request returned an '
                'invalid status code of ${response.statusCode}.',
            requestOptions: response.requestOptions,
            response: response.data,
            error: reviews));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ProvinceModel>>> getAllProvinces() async {
    try {
      final response = await DioHelper.dio.get('/resource/province/all');
      final provinces = (response.data['data'] as List)
          .map((e) => ProvinceModel.fromJson(e))
          .toList();
      if (response.statusCode == 200) {
        return DataSuccess(provinces);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<DistrictModel>>> getAllDistricts() async {
    try {
      final response = await DioHelper.dio.get('/resource/district/all');
      final districts = (response.data['data'] as List)
          .map((e) => DistrictModel.fromJson(e))
          .toList();
      if (response.statusCode == 200) {
        return DataSuccess(districts);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllWishlist() async {
    try {
      final response = await DioHelper.dio.get('/users/favorites');
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllToursRcmTag(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    try {
      final response = await DioHelper.dio.get('/analytic/user/tag');
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllToursRcmLocation(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    try {
      final response = await DioHelper.dio.get('/analytic/user/location');
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllToursRcmSearch(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    try {
      final response = await DioHelper.dio.get('/analytic/search');
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TourModel>>> getAllToursSponsore(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) async {
    try {
      final response = await DioHelper.dio.get('/analytic/boost');
      List<TourModel> tours = [];

      if (response.data['data'] != null &&
          (response.data['data'] as List).isNotEmpty) {
        tours = (response.data['data'] as List)
            .map((e) => TourModel.fromJson(e))
            .toList();
      }
      if (response.statusCode == 200) {
        return DataSuccess(tours);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState> analyticLocation(Set<String> locations) async {
    try {
      final Map<String, dynamic> data = {"locations": locations.toList()};
      final response =
          await DioHelper.dio.post('/analytic/user/location', data: data);
      if (response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState> analyticTag(Set<int> tags) async {
    try {
      final Map<String, dynamic> data = {"tags": tags.toList()};

      final response =
          await DioHelper.dio.post('/analytic/user/tag', data: data);

      if (response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<dynamic>>> getPopularLocation() async {
    try {
      final response = await DioHelper.dio.get('/analytic/popular/location');

      if (response.statusCode == 200) {
        return DataSuccess(response.data['data']);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TourModel>> getTourDetail(tourId) async {
    try {
      final response = await DioHelper.dio.get('/tour/get/$tourId');

      if (response.statusCode == 200) {
        final tour = TourModel.fromJson(response.data["data"]);
        return DataSuccess(tour);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> getBanner() async {
    try {
      final response = await DioHelper.dio.get('/global/banner');

      if (response.statusCode == 200) {
        final banner = response.data["data"];
        return DataSuccess(banner);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          message: 'The request returned an '
              'invalid status code of ${response.statusCode}.',
          requestOptions: response.requestOptions,
          response: response.data,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
