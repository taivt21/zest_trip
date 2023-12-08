import 'package:zest_trip/features/home/data/models/tour_model.dart';
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
    String? addressWard,
    String? companyName,
    List<String>? socialMedia,
    String? avatarImageUrl,
    String? bannerImageUrl,
    String? businessLicense,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avgRating,
    List<TourModel>? tours,
    String? serviceType,
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
          addressWard: addressWard,
          companyName: companyName,
          socialMedia: socialMedia,
          avatarImageUrl: avatarImageUrl,
          bannerImageUrl: bannerImageUrl,
          businessLicense: businessLicense,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          avgRating: avgRating,
          tours: tours,
          serviceType: serviceType,
        );

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      addressName: json['address_name'],
      addressDistrict: json['address_district'],
      addressWard: json['address_ward'],
      addressProvince: json['address_province'],
      addressCountry: json['address_country'],
      companyName: json['company_name'],
      serviceType: json['service_type'],
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
      // tours: json.containsKey('Tour')
      //     ? List<TourModel>.from(
      //         json['Tour'].map((component) => TourModel.fromJson(component)))
      //     : [],
      // status: json.containsKey('status') ? json['status'] : null,
      avgRating: json['avgRating'].toString(),
    );
  }
}
