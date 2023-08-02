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
  final String fullName;
  final String dob;
  final String gender;

  const RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.dob,
    required this.gender,
  });

  @override
  List<Object> get props => [email, password, fullName, dob, gender];
}

class SignInWithGoogleEvent extends AuthEvent {}
