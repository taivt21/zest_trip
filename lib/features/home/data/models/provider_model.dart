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
      id: json.containsKey('id') ? json['id'] : null,
      description: json.containsKey('description') ? json['description'] : null,
      phone: json.containsKey('phone') ? json['phone'] : null,
      email: json.containsKey('email') ? json['email'] : null,
      addressName:
          json.containsKey('address_name') ? json['address_name'] : null,
      addressDistrict: json.containsKey('address_district')
          ? json['address_district']
          : null,
      addressCity:
          json.containsKey('address_city') ? json['address_city'] : null,
      addressProvince: json.containsKey('address_province')
          ? json['address_province']
          : null,
      addressCountry:
          json.containsKey('address_country') ? json['address_country'] : null,
      companyName:
          json.containsKey('company_name') ? json['company_name'] : null,
      socialMedia: (json.containsKey('social_media') &&
              json['social_media'] is List<String>)
          ? (json['social_media'] as List<String>)
              .map((e) => e.toString())
              .toList()
          : [],
      avatarImageUrl: json.containsKey('avatar_image_url')
          ? json['avatar_image_url']
          : "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      bannerImageUrl: json.containsKey('banner_image_url')
          ? json['banner_image_url']
          : "https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png?ssl=1",
      businessLicense: json.containsKey('business_license')
          ? json['business_license']
          : null,
      // status: json.containsKey('status') ? json['status'] : null,
      // avgRating: json.containsKey('avgRating') ? json['avgRating'] : null,
      createdAt: json.containsKey('created_at')
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json.containsKey('updated_at')
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
