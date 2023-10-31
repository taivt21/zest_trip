import 'dart:io';

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
  final String otp;

  const RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.otp,
  });

  @override
  List<Object> get props => [email, password, otp];
}

class SignInWithGoogleEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class LoginWithPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  const LoginWithPhoneNumberEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerificationEmailEvent extends AuthEvent {
  final String email;

  const VerificationEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}
class UploadImageEvent extends AuthEvent {
  final File file;
  const UploadImageEvent(this.file);
}

class CheckUserLoginEvent extends AuthEvent {}
