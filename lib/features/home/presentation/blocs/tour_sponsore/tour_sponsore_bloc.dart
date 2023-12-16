import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_sponsore.dart';

part 'tour_sponsore_event.dart';
part 'tour_sponsore_state.dart';

class TourSponsoreBloc extends Bloc<TourSponsoreEvent, TourSponsoreState> {
  final GetTourSponsoreUseCase _getTourSponsoreUseCase;

  TourSponsoreBloc(
    this._getTourSponsoreUseCase,
  ) : super(TourSponsoreInitial()) {
    // on<TourSponsoreEvent>((event, emit) {});
    on<GetToursSponsore>((event, emit) async {
      emit(TourSponsoreInitial());
      final dataState = await _getTourSponsoreUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursSponsoreSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(GetToursSponsoreFail(dataState.error!));
      }
    });
  }
}
