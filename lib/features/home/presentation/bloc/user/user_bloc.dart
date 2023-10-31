// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zest_trip/config/utils/resources/data_state.dart';

import 'package:zest_trip/features/authentication/domain/usecases/upload_image_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UploadImageUseCase uploadImageUseCase;

  UserBloc(this.uploadImageUseCase) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<UploadImageEvent>((event, emit) async {
      final dataState = await uploadImageUseCase.call(event.file);

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        // emit(UserUploadSuccess(dataState.data!));
      }
      if (dataState is DataFailed) {
        // emit(RemoteTourTagError(dataState.error!));
      }
    });
  }
}
