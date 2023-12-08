// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:zest_trip/config/utils/resources/data_state.dart';
import 'package:zest_trip/features/home/domain/usecases/get_banner.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerUseCase _getBannerUseCase;
  BannerBloc(
    this._getBannerUseCase,
  ) : super(BannerInitial()) {
    on<BannerEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetBanner>(
      (event, emit) async {
        final dataState = await _getBannerUseCase.call();

        if (dataState is DataSuccess) {
          emit(GetBannerSuccess(dataState.data!));
        }
        if (dataState is DataFailed) {
          emit(GetBannerFail(dataState.error!));
        }
      },
    );
  }
}
