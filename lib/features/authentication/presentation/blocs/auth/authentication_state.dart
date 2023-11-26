// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';

abstract class AuthState extends Equatable {
  final AuthUser? user;
  final DioException? error;
  const AuthState({
    this.user,
    this.error,
  });

  @override
  List<Object?> get props => [error, user];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  const AuthSuccess(AuthUser user) : super(user: user);
}

final class VerifyInProgressState extends AuthState {}

final class VerifiedState extends AuthState {}

final class VerifiedFailState extends AuthState {
  const VerifiedFailState(DioException e) : super(error: e);
}

final class AuthFailure extends AuthState {
  const AuthFailure(DioException e) : super(error: e);
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
