import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/get_popular_tag.dart';
part 'tag_popular_event.dart';
part 'tag_popular_state.dart';

class TagPopularBloc extends Bloc<TagPopularEvent, TagPopularState> {
  final GetPopularTagUseCase _getPopularTagUseCase;
  TagPopularBloc(this._getPopularTagUseCase) : super(TagPopularInitial()) {
    on<TagPopularEvent>((event, emit) {});
    on<GetPopularTag>((event, emit) async {
      final dataState = await _getPopularTagUseCase.call();

      if (dataState is DataSuccess) {
        emit(GetPopularTagSuccess(dataState.data ?? []));
      }
      if (dataState is DataFailed) {
        emit(GetPopularTagFail(dataState.error!));
      }
    });
  }
}
