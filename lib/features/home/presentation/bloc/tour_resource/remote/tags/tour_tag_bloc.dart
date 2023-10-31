// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';

import 'package:zest_trip/features/home/data/models/tour_tag.dart';
import 'package:zest_trip/features/home/domain/usecases/tour_usecases/get_tags.dart';

part 'tour_tag_event.dart';
part 'tour_tag_state.dart';

class TourTagBloc extends Bloc<TourResourceEvent, TourTagState> {
  final GetTourTagsUseCase _getTourTagsUseCase;
  TourTagBloc(
    this._getTourTagsUseCase,
  ) : super(const RemoteTourTagLoading()) {
    on<GetTourTags>((event, emit) async {
      final dataState = await _getTourTagsUseCase.call();

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteTourTagDone(dataState.data!));
      }
      if (dataState is DataFailed) {
        emit(RemoteTourTagError(dataState.error!));
      }
    });
  }
}
