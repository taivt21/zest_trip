import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class GetOwnBookingUseCase {
  final PaymentRepository _repository;

  GetOwnBookingUseCase(this._repository);

  Future<DataState<List<InvoiceEntity>>> call() async {
    return await _repository.getOwnBooking();
  }
}
