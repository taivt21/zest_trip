import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_event.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_state.dart';

class RemoteTourBloc extends Bloc<RemoteTourEvent, RemoteTourState> {
  final GetTourUseCase _getTourUseCase;

  RemoteTourBloc(
    this._getTourUseCase,
  ) : super(const RemoteTourLoading()) {
    on<ClearTour>((event, emit) {
      emit(const RemoteTourDone(tours: [], hasMore: false));
      emit(const RemoteTourLoading());
    });

    on<GetTours>((event, emit) async {
      final currentState = state;

      final dataState = await _getTourUseCase.call(
        page: event.page,
        limit: event.limit ?? 5,
        tagIds: event.tags,
        search: event.search ?? "",
        province: event.province ?? "",
        district: event.district ?? "",
      );

      if (dataState is DataSuccess) {
        if (currentState is RemoteTourDone) {
          // emit(const RemoteTourLoading());
          final updatedTours = List<TourEntity>.from(currentState.tours ?? []);
          updatedTours.addAll(dataState.data!);
          emit(RemoteTourDone(
              tours: updatedTours,
              hasMore: dataState.data!.isEmpty ? true : false));
        } else {
          emit(RemoteTourDone(tours: dataState.data!, hasMore: true));
        }
      }

      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(RemoteTourError(dataState.error!));
      }
    });
  }
}
