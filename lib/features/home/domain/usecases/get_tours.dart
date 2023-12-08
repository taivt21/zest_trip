import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

import '../../../../config/utils/resources/data_state.dart';
import '../entities/tour_entity.dart';

class GetTourUseCase {
  final TourRepository _tourRepository;

  GetTourUseCase(this._tourRepository);

  Future<DataState<List<TourEntity>>> call({
    String? search,
    int? page,
    int? limit,
    String? orderBy,
    Set<int>? tagIds,
    Set<int>? vehicleIds,
    String? province,
    String? district,
    int? lowPrice,
    int? highPrice,
  }) {
    return _tourRepository.getAllTours(
      limit: limit,
      search: search,
      page: page,
      orderBy: orderBy,
      tagIds: tagIds,
      province: province,
      district: district,
      lowPrice: lowPrice,
      highPrice: highPrice,
    );
  }
}
