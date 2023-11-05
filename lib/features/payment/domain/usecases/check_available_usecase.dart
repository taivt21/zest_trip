import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class CheckAvailableUseCase {
  final PaymentRepository _repository;

  CheckAvailableUseCase(this._repository);

  Future<DataState<dynamic>> call(
      String tourId, int adult, int children, DateTime date) async {
    return await _repository.checkAvailable(tourId, adult, children, date);
  }
}
