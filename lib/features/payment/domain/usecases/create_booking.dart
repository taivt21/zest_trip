import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class CreateBookingUseCase {
  final PaymentRepository _repository;

  CreateBookingUseCase(this._repository);

  Future<DataState<dynamic>> call(BookingEntity bookingEntity,
      String redirectUrl, int voucherId, String location) async {
    return await _repository.createBooking(
        bookingEntity, redirectUrl, voucherId, location);
  }
}
