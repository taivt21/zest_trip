import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/data/models/tour_vehicle.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetTourVehiclesUseCase {
  final TourRepository _repository;

  GetTourVehiclesUseCase(this._repository);

  Future<DataState<List<TourVehicle>>> call() {
    return _repository.getAllVehicles();
  }
}
