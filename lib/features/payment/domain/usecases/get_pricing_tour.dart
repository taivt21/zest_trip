import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_check_booking_entity.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class GetPricingTourUseCase {
  final PaymentRepository _repository;

  GetPricingTourUseCase(this._repository);

  Future<DataState<TourCheckBookingEntity>> call(String tourId) async {
    return await _repository.getCheckingTour(tourId);
  }
}
