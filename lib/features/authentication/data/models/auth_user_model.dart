import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    String? id,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? dob,
    String? gender,
    int? roleId,
    String? countryCode,
    String? avatarImageUrl,
    String? bannerImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    bool? isRecommendRracked,
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
          isRecommendRracked: isRecommendRracked,
        );

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json.containsKey('id') ? json['id'] : "",
      roleId: json.containsKey('role_id') ? json['role_id'] : 1,
      countryCode: json.containsKey('country_code') ? json['country_code'] : "",
      fullName: json.containsKey('full_name') ? json['full_name'] : null,
      dob: json.containsKey('dob') ? json['dob'] : "",
      email: json.containsKey('email') ? json['email'] : "",
      gender: json.containsKey('gender') ? json['gender'] as String? : null,
      phoneNumber: json.containsKey('phone_number') ? json['phone_number'] : "",
      avatarImageUrl: json['avatar_image_url'],
      bannerImageUrl: json['banner_image_url'] ??
          "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      isRecommendRracked: json['is_recommend_tracked'],
      // createdAt: DateTime.tryParse(json['created_at']),
      // updatedAt: DateTime.tryParse(json['updated_at']),
      status: json.containsKey('status') ? json['status'] : "",
    );
  }
}
