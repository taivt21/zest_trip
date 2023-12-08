// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';
import 'package:zest_trip/features/home/domain/entities/tour_review_entity.dart';
import 'package:zest_trip/features/payment/data/datasources/payment_api_service.dart';
import 'package:zest_trip/features/payment/domain/entities/booking_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/invoice_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_check_booking_entity.dart';
import 'package:zest_trip/features/payment/domain/entities/tour_voucher_entity.dart';
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
      BookingEntity bookingEntity, String redirectUrl, int voucherId) async {
    return await _paymentApiService.creatBooking(
        bookingEntity, redirectUrl, voucherId);
  }

  @override
  Future<DataState<List<InvoiceEntity>>> getOwnBooking(String userId) async {
    return await _paymentApiService.getOwnBooking(userId);
  }

  @override
  Future<DataState<ProviderEntity>> getInfoProvider(String providerId) async {
    return await _paymentApiService.getInfoProvider(providerId);
  }

  @override
  Future<DataState<bool>> postReview(
      String content, int rating, String tourId) async {
    return await _paymentApiService.postReview(content, rating, tourId);
  }

  @override
  Future<DataState<List<TourReviewEntity>>> getOwnReview() async {
    return await _paymentApiService.getOwnReview();
  }

  @override
  Future<DataState<dynamic>> requestRefund(
      String bookingId, String reason) async {
    return await _paymentApiService.requestRefund(bookingId, reason);
  }

  @override
  Future<DataState<List<TourVoucherEntity>>> getVoucher(String tourId) async {
    return await _paymentApiService.getVoucher(tourId);
  }

  @override
  Future<DataState<TourCheckBookingEntity>> getCheckingTour(
      String tourId) async {
    return await _paymentApiService.getCheckingTour(tourId);
  }
}
