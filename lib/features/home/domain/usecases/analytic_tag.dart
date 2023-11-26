import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class AnaLyticTagUseCase {
  final TourRepository _repository;

  AnaLyticTagUseCase(this._repository);

  Future<DataState<dynamic>> call(Set<int> tags) {
    return _repository.analyticTag(tags);
  }
}
