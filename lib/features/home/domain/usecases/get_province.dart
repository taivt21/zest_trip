import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/province_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetProvinceUseCase {
  final TourRepository _repository;

  GetProvinceUseCase(this._repository);

  Future<DataState<List<ProvinceEntity>>> call() {
    return _repository.getAllProvinces();
  }
}
