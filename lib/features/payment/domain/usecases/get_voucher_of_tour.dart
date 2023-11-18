import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class GetVoucherOfTourUseCase {
  final PaymentRepository _repository;

  GetVoucherOfTourUseCase(this._repository);

  Future<DataState<List<TourVoucherEntity>>> call(String tourId) async {
    return await _repository.getVoucher(tourId);
  }
}
