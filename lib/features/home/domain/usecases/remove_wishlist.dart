import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class RemoveWishlistUseCase {
  final TourRepository _repository;

  RemoveWishlistUseCase(this._repository);

  Future<DataState<bool>> call(String tourId) async {
    return await _repository.removeFromWishlist(tourId);
  }
}
