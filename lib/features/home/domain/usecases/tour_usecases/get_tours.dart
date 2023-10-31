import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

import '../../../../../config/utils/resources/data_state.dart';
import '../../entities/tour_entity.dart';

class GetTourUseCase {
  final TourRepository _tourRepository;

  GetTourUseCase(this._tourRepository);

  Future<DataState<List<TourEntity>>> call({
    String? search,
    int? page,
    int? limit,
    String? orderBy,
  }) {
    return _tourRepository.getAllTours();
  }
}
