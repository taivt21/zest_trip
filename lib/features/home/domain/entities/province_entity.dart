import 'package:equatable/equatable.dart';

class ProvinceEntity extends Equatable {
  final String? code;
  final String? name;
  final String? nameEn;
  final String? fullname;
  final String? fullnameEn;
  final String? codeName;

  const ProvinceEntity({
    this.code,
    this.name,
    this.nameEn,
    this.fullname,
    this.fullnameEn,
    this.codeName,
  });

  @override
  List<Object?> get props => [
        code,
        name,
        nameEn,
        fullname,
        fullnameEn,
        codeName,
      ];
}
