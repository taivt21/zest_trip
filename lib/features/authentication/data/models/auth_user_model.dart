import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    String? id,
    int? roleId,
    String? countryCode,
    String? fullName,
    String? dob,
    String? email,
    String? phoneNumber,
    String? gender,
    String? password,
    String? avatarImageUrl,
    String? bannerImageUrl,
    String? createdAt,
    String? updatedAt,
    String? status,
  }) : super(
          id: id,
          roleId: roleId,
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

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      roleId: json['role_id'],
      countryCode: json['country_code'],
      fullName: json['full_name'],
      dob: json['dob'],
      email: json['email'],
      gender: json['gender'],
      password: json['password'],
      avatarImageUrl: json['avatar_image_url'],
      bannerImageUrl: json['banner_image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'country_code': countryCode,
      'full_name': fullName,
      'dob': dob,
      'email': email,
      'gender': gender,
      'password': password,
      'avatar_image_url': avatarImageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
    };
  }
}
