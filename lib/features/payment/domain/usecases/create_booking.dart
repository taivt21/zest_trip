import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class CreateBookingUseCase {
  final PaymentRepository _repository;

  CreateBookingUseCase(this._repository);

  Future<DataState<dynamic>> call(
      String name,
      String phone,
      String email,
      int adult,
      int children,
      DateTime date,
      String tourId,
      String redirectUrl) async {
    return await _repository.createBooking(
        name, phone, email, adult, children, date, tourId, redirectUrl);
  }
}
