import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class PostReviewUseCase {
  final PaymentRepository _repository;

  PostReviewUseCase(this._repository);

  Future<DataState<bool>> call(
      String content, int rating, String tourId) async {
    return await _repository.postReview(content, rating, tourId);
  }
}
