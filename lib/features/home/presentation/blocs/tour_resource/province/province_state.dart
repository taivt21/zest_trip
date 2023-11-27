part of 'province_bloc.dart';

abstract class ProvinceState extends Equatable {
  final List<ProvinceEntity>? provinces;
  final DioException? error;

  const ProvinceState({this.provinces, this.error});

  @override
  List<Object?> get props => [provinces, error];
}

final class ProvinceInitial extends ProvinceState {}

final class GetProvinceSuccess extends ProvinceState {
  const GetProvinceSuccess(List<ProvinceEntity> provinces)
      : super(provinces: provinces);
}

final class GetProvinceFail extends ProvinceState {
  const GetProvinceFail(DioException e) : super(error: e);
}
