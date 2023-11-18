import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class RequestRefundUseCase {
  final PaymentRepository _repository;

  RequestRefundUseCase(this._repository);

  Future<DataState<dynamic>> call(String bookingId, String reason) async {
    return await _repository.requestRefund(bookingId, reason);
  }
}
