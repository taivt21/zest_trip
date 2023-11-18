import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/home/domain/repositories/tour_repository.dart';

class GetReviewsUseCase {
  final TourRepository _repository;

  GetReviewsUseCase(this._repository);

  Future<DataState<List<TourReviewEntity>>> call(String tourId) async {
    return await _repository.getReviews(tourId);
  }
}
