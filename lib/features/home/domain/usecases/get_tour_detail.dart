import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetTourDetailUseCase {
  final TourRepository _repository;

  GetTourDetailUseCase(this._repository);

  Future<DataState<TourEntity>> call(String tourId) {
    return _repository.getTourDetail(tourId);
  }
}
