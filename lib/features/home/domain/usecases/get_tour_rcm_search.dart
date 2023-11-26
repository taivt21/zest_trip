import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

import '../../../../config/utils/resources/data_state.dart';
import '../entities/tour_entity.dart';

class GetTourRcmSearchUseCase {
  final TourRepository _tourRepository;

  GetTourRcmSearchUseCase(this._tourRepository);

  Future<DataState<List<TourEntity>>> call(
      {String? search,
      int? page,
      int? limit,
      String? orderBy,
      Set<int>? tagIds}) {
    return _tourRepository.getAllToursRcmSearch(
        limit: limit,
        search: search,
        page: page,
        orderBy: orderBy,
        tagIds: tagIds);
  }
}
