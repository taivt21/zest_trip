import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/add_wishlist.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/get_tours.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/post_review.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour/remote/remote_tour_event.dart';
import 'package:zest_trip/features/home/presentation/bloc/tour/remote/remote_tour_state.dart';

class RemoteTourBloc extends Bloc<RemoteTourEvent, RemoteTourState> {
  final GetTourUseCase _getTourUseCase;
  final AddWishlistUseCase _addWishlistUseCase;
  final PostReviewUseCase _postReviewUseCase;

  RemoteTourBloc(
      this._getTourUseCase, this._addWishlistUseCase, this._postReviewUseCase)
      : super(const RemoteTourLoading()) {
    on<GetTours>((event, emit) async {
      final dataState = await _getTourUseCase.call();

      if (dataState is DataSuccess) {
        emit(RemoteTourDone(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(RemoteTourError(dataState.error!));
      }
    });

    on<AddToWishlist>((event, emit) async {
      final dataState = await _addWishlistUseCase.call(event.tourId);

      if (dataState is DataSuccess) {
        emit(const AddedToWishlist());
      } else if (dataState is DataFailed) {
        emit(AddToWishlistError(dataState.error!));
      }
    });

    on<PostReview>(((event, emit) async {
      final dataState = await _postReviewUseCase.call(
          event.content, event.rating, event.tourId);
      if (dataState is DataSuccess) {
        emit(const ReviewSuccess());
      } else if (dataState is DataFailed) {
        emit(ReviewFail(dataState.error!));
      }
    }));
  }
}
