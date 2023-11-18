import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';

abstract class PaymentRepository {
  Future<DataState<dynamic>> checkAvailable(
      String tourId, int adult, int children, DateTime date);
  Future<DataState<bool>> postReview(String content, int rating, String tourId);
  Future<DataState<dynamic>> createBooking(
      BookingEntity bookingEntity, String redirectUrl);
  Future<DataState<dynamic>> requestRefund(String bookingId, String reason);
  Future<DataState<List<InvoiceEntity>>> getOwnBooking();
  Future<DataState<List<TourReviewEntity>>> getOwnReview();
  Future<DataState<List<TourVoucherEntity>>> getVoucher(String tourId);
  Future<DataState<ProviderEntity>> getInfoProvider(String providerId);
}
