import 'package:equatable/equatable.dart';

// They are the business objects of the application (Enterprise-wide business rules)
// and encapsulate the most general and high-level rules.
class AuthUser extends Equatable {
  final String? id;
  final String? idRole;
  final String? countryCode;
  final String? fullName;
  final String? dob;
  final String? email;
  final String? gender;
  final String? password;
  final String? avatarImageUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  // For example, a high-level rule for a User entity might be
  // that a user age cannot be lower than 18.
  // final int age;

  const AuthUser({
    this.id,
    this.idRole,
    this.countryCode,
    this.fullName,
    this.dob,
    this.email,
    this.gender,
    this.password,
    this.avatarImageUrl,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  // static const AuthUser empty = AuthUser(
  //   id: '',
  //   name: '',
  //   email: '',
  //   photoUrl: '',
  // );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  // bool get isEmpty => this == AuthUser.empty;

  @override
  List<Object?> get props => [
        id,
        idRole,
        countryCode,
        fullName,
        dob,
        email,
        gender,
        password,
        avatarImageUrl,
        createdAt,
        updatedAt,
        status,
      ];

  // DO NOT ADD THIS CONSTRUCTOR:
  // It's not the role of the entity to know how to serialize
  // and deserialize data from external data source.
  // factory AuthUser.fromJson(Map<String, dynamic> json) {
  //   return AuthUser(
  //     id: json['id'] as String,
  //     name: json['name'] as String,
  //     email: json['email'] as String,
  //     photoUrl: json['photoUrl'] as String,
  //   );
  // }
}





// They are plain Dart (or whatever language you're using) classes and don't have
// any dependencies on other layers.


// In the context of Clean Architecture, "business objects" refer to the main components
// or objects that the application is built around. These are usually things that
// represent real-world objects or concepts that are relevant to what the
// application does. For example, in a banking app, some of the business objects
// might be Account, Transaction, or Customer.

// These rules are the basic principles or guidelines that define how the
// entities behave or interact.This rule would be "encapsulated" in the Account entity, meaning that
// it's a fundamental part of what defines an Account in
// the context of the application.