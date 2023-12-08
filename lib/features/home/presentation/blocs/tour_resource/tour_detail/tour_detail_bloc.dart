// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';

import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_detail.dart';

part 'tour_detail_event.dart';
part 'tour_detail_state.dart';

class TourDetailBloc extends Bloc<TourDetailEvent, TourDetailState> {
  final GetTourDetailUseCase _getTourDetailUseCase;
  TourDetailBloc(
    this._getTourDetailUseCase,
  ) : super(TourDetailInitial()) {
    on<TourDetailEvent>(
      (event, emit) {},
    );
    on<GetTourDetail>((event, emit) async {
      final dataState = await _getTourDetailUseCase.call(event.tourId);

      if (dataState is DataSuccess) {
        emit(GetTourDetailSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(GetTourDetailFail(dataState.error!));
      }
    });
  }
}
