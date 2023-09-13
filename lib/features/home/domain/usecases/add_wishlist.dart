import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repository/tour_repository.dart';

class AddWishlistUseCase {
  final TourRepository _repository;

  AddWishlistUseCase(this._repository);

  Future<DataState<bool>> call(String tourId) async {
    return await _repository.addToWishlist(tourId);
  }
}
