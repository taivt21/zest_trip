import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/tour_entity.dart';

class GetTourUseCase implements UseCase<DataState<List<TourEntity>>, void> {
  final TourRepository _tourRepository;

  GetTourUseCase(this._tourRepository);

  @override
  Future<DataState<List<TourEntity>>> call({void params}) {
    return _tourRepository.getAllTours();
  }
}
