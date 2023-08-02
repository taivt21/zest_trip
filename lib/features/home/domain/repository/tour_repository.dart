import 'package:zest_trip/core/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';

abstract class TourRepository {
  Future<DataState<TourEntity>> getTours(String id);
  Future<DataState<List<TourEntity>>> getAllTours();
}
