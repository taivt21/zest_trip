import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/domain/usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/get_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/remove_wishlist.dart';

part 'tour_wishlist_event.dart';
part 'tour_wishlist_state.dart';

class TourWishlistBloc extends Bloc<TourWishlistEvent, TourWishlistState> {
  final AddWishlistUseCase _addWishlistUseCase;
  final RemoveWishlistUseCase _removeWishlistUseCase;
  final GetWishlistUseCase _getWishlistUseCase;

  TourWishlistBloc(this._addWishlistUseCase, this._removeWishlistUseCase,
      this._getWishlistUseCase)
      : super(TourWishlistInitial()) {
    on<TourWishlistEvent>((event, emit) {});
    on<AddWishlist>((event, emit) async {
      emit(TourWishlistInitial());
      final dataState = await _addWishlistUseCase.call(event.tourId);

      if (dataState is DataSuccess) {
      
        final dataStates = await _getWishlistUseCase.call();
        emit(GetToursWishlistSuccess(dataStates.data!));
      }
      if (dataState is DataFailed) {
        emit(WishlistFail());
      }
    });
    on<RemoveWishlist>((event, emit) async {
      emit(TourWishlistInitial());
      final dataState = await _removeWishlistUseCase.call(event.tourId);

      if (dataState is DataSuccess) {
        // emit(RemovedWishlist());
        final dataStates = await _getWishlistUseCase.call();
        emit(GetToursWishlistSuccess(dataStates.data!));
      }
      if (dataState is DataFailed) {
        emit(WishlistFail());
      }
    });
    on<GetWishlist>((event, emit) async {
      emit(TourWishlistInitial());
      final dataState = await _getWishlistUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetToursWishlistSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(GetToursWishlistFail(dataState.error!));
      }
    });
  }
}
