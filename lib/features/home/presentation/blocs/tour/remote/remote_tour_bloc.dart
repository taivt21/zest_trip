import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/get_tours.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_event.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour/remote/remote_tour_state.dart';

class RemoteTourBloc extends Bloc<RemoteTourEvent, RemoteTourState> {
  final GetTourUseCase _getTourUseCase;
  final AddWishlistUseCase _addWishlistUseCase;

  RemoteTourBloc(
    this._getTourUseCase,
    this._addWishlistUseCase,
  ) : super(const RemoteTourLoading()) {
    on<GetTours>((event, emit) async {
      final dataState = await _getTourUseCase.call();

      if (dataState is DataSuccess) {
        emit(RemoteTourDone(dataState.data!));
      }
      if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(RemoteTourError(dataState.error!));
      }
    });

    on<AddToWishlist>((event, emit) async {
      final dataState = await _addWishlistUseCase.call(event.tourId);

      if (dataState is DataSuccess) {
        emit(const AddedToWishlist());
      } else if (dataState is DataFailed) {
        print(dataState.error?.response?.data["message"]);
        emit(AddToWishlistError(dataState.error!));
      }
    });
  }
}
