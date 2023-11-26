import 'package:zest_trip/features/home/domain/entities/province_entity.dart';

class ProvinceModel extends ProvinceEntity {
  const ProvinceModel({
    String? code,
    String? name,
    String? nameEn,
    String? fullname,
    String? fullnameEn,
    String? codeName,
  }) : super(
            code: code,
            name: name,
            nameEn: nameEn,
            fullname: fullname,
            fullnameEn: fullnameEn,
            codeName: codeName);

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      // code: json['code'],
      name: json['name'],
      // nameEn: json['name_en'],
      // fullname: json['fullname'],
      // fullnameEn: json['fullname_en'],
      // codeName: json['code_name'],
    );
  }
}
