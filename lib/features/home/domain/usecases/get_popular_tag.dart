import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetPopularTagUseCase {
  final TourRepository _repository;

  GetPopularTagUseCase(this._repository);

  Future<DataState<List<dynamic>>> call() {
    return _repository.getPopularTag();
  }
}
