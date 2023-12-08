import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetWishlistUseCase {
  final TourRepository _repository;

  GetWishlistUseCase(this._repository);

  Future<DataState<List<TourEntity>>> call() {
    return _repository.getAllWishlist();
  }
}
