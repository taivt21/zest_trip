import 'package:zest_trip/features/home/domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    String? id,
    String? description,
    String? phone,
    String? email,
    String? addressName,
    String? addressDistrict,
    String? addressCity,
    String? addressProvince,
    String? addressCountry,
    String? companyName,
    List<String>? socialMedia,
    String? avatarImageUrl,
    String? bannerImageUrl,
    String? businessLicense,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avgRating,
  }) : super(
          id: id,
          description: description,
          phone: phone,
          email: email,
          addressName: addressName,
          addressDistrict: addressDistrict,
          addressCity: addressCity,
          addressProvince: addressProvince,
          addressCountry: addressCountry,
          companyName: companyName,
          socialMedia: socialMedia,
          avatarImageUrl: avatarImageUrl,
          bannerImageUrl: bannerImageUrl,
          businessLicense: businessLicense,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          avgRating: avgRating,
        );

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      addressName: json['address_name'],
      addressDistrict: json['address_district'],
      addressProvince: json['address_province'],
      addressCountry: json['address_country'],
      companyName: json['company_name'],
      socialMedia: (json['social_media'] is List<String>)
          ? (json['social_media'] as List<String>).toList()
          : [],
      avatarImageUrl: json['avatar_image_url'] ??
          "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      bannerImageUrl: json['banner_image_url'] ??
          "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      businessLicense: json['business_license'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      // status: json.containsKey('status') ? json['status'] : null,
      avgRating: json['avgRating'],
    );
  }
}
