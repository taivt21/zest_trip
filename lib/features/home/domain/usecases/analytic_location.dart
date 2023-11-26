import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class AnaLyticLocationUseCase {
  final TourRepository _repository;

  AnaLyticLocationUseCase(this._repository);

  Future<DataState<dynamic>> call(Set<String> locations) {
    return _repository.analyticLocation(locations);
  }
}
