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
            updatedAt: updatedAt);

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      addressName: json['address_name'],
      addressDistrict: json['address_district'],
      addressCity: json['address_city'],
      addressProvince: json['address_province'],
      addressCountry: json['address_country'],
      companyName: json['company_name'],
      socialMedia: List<String>.from(json['social_media']),
      avatarImageUrl: json['avatar_image_url'],
      bannerImageUrl: json['banner_image_url'],
      businessLicense: json['business_license'],
      status: json['status'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }
}
