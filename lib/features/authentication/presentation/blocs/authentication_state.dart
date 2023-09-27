import 'package:equatable/equatable.dart';
import 'package:zest_trip/features/authentication/domain/entities/auth_user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthUser user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterSuccess extends AuthState {}

class VerifyInProgressState extends AuthState {}

class VerifiedState extends AuthState {}

class VerifiedFailState extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AuthLoggedOut extends AuthState {}
