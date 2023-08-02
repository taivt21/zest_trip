import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    String? id,
    String? idRole,
    String? countryCode,
    String? fullName,
    String? dob,
    String? email,
    String? gender,
    String? password,
    String? avatarImageUrl,
    String? createdAt,
    String? updatedAt,
    String? status,
  }) : super(
          id: id,
          idRole: idRole,
          countryCode: countryCode,
          fullName: fullName,
          dob: dob,
          email: email,
          gender: gender,
          password: password,
          avatarImageUrl: avatarImageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          status: status,
        );
  // factory AuthUserModel.fromFirebaseAuthUser(
  //   firebase_auth.User firebaseUser,
  // ) {
  //   return AuthUserModel(
  //     id: firebaseUser.uid,
  //     email: firebaseUser.email ?? '',
  //     name: firebaseUser.displayName,
  //     photoUrl: firebaseUser.photoURL,
  //   );
  // }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      idRole: json['Id_Role'],
      countryCode: json['country_code'],
      fullName: json['full_name'],
      dob: json['dob'],
      email: json['email'],
      gender: json['gender'],
      password: json['password'],
      avatarImageUrl: json['avatar_image_url'],
      createdAt: json['Created_At'],
      updatedAt: json['Updated_At'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Id_Role': idRole,
      'country_code': countryCode,
      'full_name': fullName,
      'dob': dob,
      'email': email,
      'gender': gender,
      'password': password,
      'avatar_image_url': avatarImageUrl,
      'Created_At': createdAt,
      'Updated_At': updatedAt,
      'status': status,
    };
  }
  // AuthUser toEntity() {
  //   return AuthUser(
  //     id: id,
  //     email: email,
  //     name: name,
  //     photoUrl: photoUrl,
  //     token: '',
  //   );
  // }

  // AuthUserModel copyWith({String? token}) {
  //   return AuthUserModel(
  //     id: id,
  //     email: email,
  //     name: name,
  //     photoURL: photoURL,
  //     token: token ?? this.token,
  //   );
  // }
}
