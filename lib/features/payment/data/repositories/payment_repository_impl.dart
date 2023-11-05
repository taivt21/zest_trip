// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/data/datasources/payment_api_service.dart';
import 'package:zest_trip/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentApiService _paymentApiService;
  PaymentRepositoryImpl(
    this._paymentApiService,
  );
  @override
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date) async {
    return await _paymentApiService.checkAvailable(
        tourId, adult, children, date);
  }

  @override
  Future<DataState> createBooking(
      String name,
      String phone,
      String email,
      int adult,
      int children,
      DateTime date,
      String tourId,
      String redirectUrl) async {
    return await _paymentApiService.creatBooking(
        name, phone, email, adult, children, date, tourId, redirectUrl);
  }
}
