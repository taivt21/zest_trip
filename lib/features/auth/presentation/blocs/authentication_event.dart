import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordEvent(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String? fullName;
  final String? phone;
  final String? gender;

  const RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    this.fullName,
    this.phone,
    this.gender,
  });

  @override
  List<Object> get props =>
      [email, password, fullName ?? "", phone ?? "", gender ?? ""];
}

class SignInWithGoogleEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class LoginWithPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  const LoginWithPhoneNumberEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
