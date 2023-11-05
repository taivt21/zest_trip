import 'package:zest_trip/config/utils/resources/data_state.dart';

abstract class PaymentRepository {
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date);

  Future<DataState<dynamic>> createBooking(
      String name,
      String phone,
      String email,
      int adult,
      int children,
      DateTime date,
      String tourId,
      String redirectUrl);
}
