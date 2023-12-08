import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class ReportProviderUseCase {
  final TourRepository _repository;

  ReportProviderUseCase(this._repository);

  Future<DataState<bool>> call(String providerId, String reason, String type) async {
    return await _repository.reportProvider(providerId, reason, type);
  }
}
