import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';

class GetTourTagsUseCase {
  final TourRepository _repository;

  GetTourTagsUseCase(this._repository);

  Future<DataState<List<TourTag>>> call() {
    return _repository.getAllTags();
  }
}
