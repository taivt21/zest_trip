// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  final String? code;
  final String? name;
  final String? nameEn;
  final String? fullname;
  final String? fullnameEn;
  final String? codeName;
  final String? provinceCode;
  final int? administrativeUnitId;

  const DistrictEntity({
    this.code,
    this.name,
    this.nameEn,
    this.fullname,
    this.fullnameEn,
    this.codeName,
    this.provinceCode,
    this.administrativeUnitId,
  });

  @override
  List<Object?> get props => [
        code,
        name,
        nameEn,
        fullname,
        fullnameEn,
        codeName,
        provinceCode,
        administrativeUnitId,
      ];
}
