part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends UserEvent {
  final File file;
  const UploadImageEvent(this.file);
}
