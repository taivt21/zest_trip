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
    String? avatarImageUrl,
    String? bannerImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
  }) : super(
          id: id,
          roleId: roleId,
          countryCode: countryCode,
          fullName: fullName,
          dob: dob,
          email: email,
          gender: gender,
          avatarImageUrl: avatarImageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          status: status,
        );

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] ?? "",
      roleId: json['role_id'] ?? 1,
      countryCode: json['country_code'] ?? "",
      fullName: json['full_name'] ?? "Username",
      dob: json['dob'] ?? "",
      email: json['email'] ?? "",
      gender: json['gender'] as String?,
      phoneNumber: json['phone_number'] ?? "",
      avatarImageUrl: json['avatar_image_url'] ??
          "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      bannerImageUrl: json['banner_image_url'] ??
          "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      // createdAt: DateTime.tryParse(json['created_at']),
      // updatedAt: DateTime.tryParse(json['updated_at']),
      // status: json['status'] ?? "",
    );
  }
}
