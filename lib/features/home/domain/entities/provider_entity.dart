import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  final String? id;
  final String? description;
  final String? phone;
  final String? email;
  final String? addressName;
  final String? addressDistrict;
  final String? addressCity;
  final String? addressProvince;
  final String? addressCountry;
  final String? companyName;
  final List<String>? socialMedia;
  final String? avatarImageUrl;
  final String? bannerImageUrl;
  final String? businessLicense;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProviderEntity({
    this.id,
    this.description,
    this.phone,
    this.email,
    this.addressName,
    this.addressDistrict,
    this.addressCity,
    this.addressProvince,
    this.addressCountry,
    this.companyName,
    this.socialMedia,
    this.avatarImageUrl,
    this.bannerImageUrl,
    this.businessLicense,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        phone,
        email,
        addressName,
        addressDistrict,
        addressCity,
        addressProvince,
        addressCountry,
        companyName,
        socialMedia,
        avatarImageUrl,
        bannerImageUrl,
        businessLicense,
        status,
        createdAt,
        updatedAt,
      ];
}
