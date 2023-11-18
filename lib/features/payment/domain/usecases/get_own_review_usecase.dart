import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class GetOwnReviewUseCase {
  final PaymentRepository _repository;

  GetOwnReviewUseCase(this._repository);

  Future<DataState<List<TourReviewEntity>>> call() async {
    return await _repository.getOwnReview();
  }
}
