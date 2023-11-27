import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/district_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetDistrictUseCase {
  final TourRepository _repository;

  GetDistrictUseCase(this._repository);

  Future<DataState<List<DistrictEntity>>> call() {
    return _repository.getAllDistricts();
  }
}
