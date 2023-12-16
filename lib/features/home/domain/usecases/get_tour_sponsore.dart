import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

import '../../../../config/utils/resources/data_state.dart';
import '../entities/tour_entity.dart';

class GetTourSponsoreUseCase {
  final TourRepository _tourRepository;

  GetTourSponsoreUseCase(this._tourRepository);

  Future<DataState<List<TourEntity>>> call() {
    return _tourRepository.getAllToursSponsore();
  }
}
