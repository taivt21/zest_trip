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

  Future<DataState<dynamic>> analyticTag(Set<int> tags);
  Future<DataState<dynamic>> analyticLocation(Set<String> locations);
  Future<DataState<List<dynamic>>> getPopularLocation();

  Future<DataState<List<TourReviewModel>>> getReviews(String tourId);
  Future<DataState<List<TourTag>>> getAllTags();
  Future<DataState<List<TourVehicle>>> getAllVehicles();
  Future<DataState<List<ProvinceModel>>> getAllProvinces();
  Future<DataState<List<DistrictModel>>> getAllDistricts();

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
  }) async {
    List<int> tags = tagIds?.toList() ?? [];
    List<int> vehicles = vehicleIds?.toList() ?? [];
    final queries = {
      "page": page,
      "limit": 5,
      "tag": tags,
      "vehicle": vehicles,
      if (province != null && province.isNotEmpty) "province": province,
      if (district != null && district.isNotEmpty) "district": district,
      if (search != null && search.isNotEmpty) "query": search,
    };
    print("data search tour: $queries");
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
      print("count tours : ${tours.length}");
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
      print("call api vehicles: $vehicles");
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
      final response = await DioHelper.dio.post('/favorite', data: data);
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
  Future<DataState<bool>> removeFromCart(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<bool>> removeFromWishlist(String tourId) {
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<TourReviewModel>>> getReviews(String tourId) async {
    try {
      final response = await DioHelper.dio.get('/review/tour/$tourId');
      final reviews = (response.data['data'] as List)
          .map((e) => TourReviewModel.fromJson(e))
          .toList();
      print("response reviews: $reviews");
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
      print("call api provinces: $provinces");
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
      print("call api districts: $districts");
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
      print("getAllToursRcmLocation: $tours");
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
      print("getAllToursRcmSearch: $tours");
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
      print("getAllToursSponsore: $tours");
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
      print("response post location: $response , data: $data");
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

      print("response post tag: $response , data: $data");
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
}
