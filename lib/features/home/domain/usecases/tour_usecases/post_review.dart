import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class PostReviewUseCase {
  final TourRepository _repository;

  PostReviewUseCase(this._repository);

  Future<DataState<bool>> call(
      String content, int rating, String tourId) async {
    return await _repository.postReview(content, rating, tourId);
  }
}
