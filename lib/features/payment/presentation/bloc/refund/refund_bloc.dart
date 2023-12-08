import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/payment/domain/usecases/request_refund_usecase.dart';

part 'refund_event.dart';
part 'refund_state.dart';

class RefundBloc extends Bloc<RefundEvent, RefundState> {
  final RequestRefundUseCase _requestRefundUseCase;
  RefundBloc(this._requestRefundUseCase) : super(RefundInitial()) {
    on<RefundEvent>((event, emit) {});
    on<RequestRefundEvent>((event, emit) async {
      emit(RefundInitial());
      final dataState =
          await _requestRefundUseCase.call(event.bookingId, event.reason);
      if (dataState is DataSuccess) {
        emit(RequestRefundSuccess());
      } else if (dataState is DataFailed) {
        emit(RequestRefundFail(dataState.error!));
      }
    });
  }
}
