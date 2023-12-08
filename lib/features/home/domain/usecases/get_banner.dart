import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetBannerUseCase {
  final TourRepository _repository;

  GetBannerUseCase(this._repository);

  Future<DataState<String>> call() {
    return _repository.getBanner();
  }
}
