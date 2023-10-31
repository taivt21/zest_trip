part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final String? imageBase64;
  final DioException? error;
  const UserState({this.error, this.imageBase64});

  @override
  List<Object?> get props => [imageBase64, error];
}

final class UserInitial extends UserState {}

final class UserUploading extends UserState {
  const UserUploading(String imageBase64) : super(imageBase64: imageBase64);
}

final class UserUploadFail extends UserState {}

final class UserUploadSuccess extends UserState {}
