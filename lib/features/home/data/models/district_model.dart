import 'package:zest_trip/features/home/domain/entities/district_entity.dart';

class DistrictModel extends DistrictEntity {
  const DistrictModel({
    String? code,
    String? name,
    String? nameEn,
    String? fullname,
    String? fullnameEn,
    String? codeName,
    String? provinceCode,
    int? administrativeUnitId,
  }) : super(
          code: code,
          name: name,
          nameEn: nameEn,
          fullname: fullname,
          fullnameEn: fullnameEn,
          codeName: codeName,
          provinceCode: provinceCode,
          administrativeUnitId: administrativeUnitId,
        );

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      // code: json['code'],
      // name: json['name'],
      // nameEn: json['name_en'],
      fullname: json['full_name'],
      // fullnameEn: json['fullname_en'],
      // codeName: json['code_name'],
      provinceCode: json['province_code'],
      // administrativeUnitId: json['administrative_unit_id'],
    );
  }
}
