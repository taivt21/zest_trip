import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_event.dart';
import 'package:zest_trip/features/home/presntation/bloc/tour/remote/remote_tour_state.dart';

class RemoteTourBloc extends Bloc<RemoteTourEvent, RemoteTourState> {
  final GetTourUseCase _getTourUseCase;

  RemoteTourBloc(this._getTourUseCase) : super(const RemoteTourLoading()) {
    on<GetTours>((event, emit) async {
      final dataState = await _getTourUseCase.call();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteTourDone(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(RemoteTourError(dataState.error!));
      }
    });
    //  on<GetToursWithTag>((event, emit) async {
    //   final dataState = await _getTourUseCase.call();

    //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
    //     final filteredTours = dataState.data!
    //         .where((tour) => tour.tags!.contains(event.tag) )
    //         .toList();
    //     emit(RemoteTourDone(filteredTours));
    //   } else if (dataState is DataFailed) {
    //     emit(RemoteTourError(dataState.error!));
    //   }
    // });
  }
}
