import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tour_provider.dart';

part 'tour_of_provider_event.dart';
part 'tour_of_provider_state.dart';

class TourProviderBloc extends Bloc<TourProviderEvent, TourProviderState> {
  final GetTourProviderUseCase _getTourProviderUseCase;

  TourProviderBloc(
    this._getTourProviderUseCase,
  ) : super(TourProviderInitial()) {
    on<TourProviderEvent>((event, emit) {});
    on<ClearTourProvider>((event, emit) {
      emit(const GetTourProviderSuccess(tours: [], hasMore: false));
      emit(TourProviderInitial());
    });
    on<GetTourProvider>((event, emit) async {
      final currentState = state;
      // if (currentState is RemoteTourDone) {
      //   currentState.hasMore == true;
      //   return;
      // }
      final dataState = await _getTourProviderUseCase.call(
        event.providerId,
        page: event.page,
        limit: event.limit,
        tagIds: event.tags,
        search: event.search ?? "",
      );

      if (dataState is DataSuccess) {
        if (currentState is GetTourProviderSuccess) {
          // emit(const RemoteTourLoading());
          final updatedTours = List<TourEntity>.from(currentState.tours ?? []);
          updatedTours.addAll(dataState.data!);
          emit(GetTourProviderSuccess(
              tours: updatedTours,
              hasMore: dataState.data!.isEmpty ? true : false));
        } else {
          emit(GetTourProviderSuccess(tours: dataState.data!, hasMore: true));
        }
      }

      if (dataState is DataFailed) {
        emit(GetTourProviderFail(dataState.error!));
      }
    });
  }
}
