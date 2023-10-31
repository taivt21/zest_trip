import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthUser user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class RegisterSuccess extends AuthState {}

final class VerifyInProgressState extends AuthState {}

final class VerifiedState extends AuthState {}

final class VerifiedFailState extends AuthState {}

final class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AuthLoggedOut extends AuthState {}

final class UserUploading extends AuthState {
  final String image;
  const UserUploading(this.image);
  @override
  List<Object> get props => [image];
}

final class UserUploadFail extends AuthState {}

final class UserUploadSuccess extends AuthState {}
