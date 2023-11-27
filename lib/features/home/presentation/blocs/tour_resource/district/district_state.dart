part of 'district_bloc.dart';

abstract class DistrictState extends Equatable {
  final List<DistrictEntity>? districts;
  final DioException? error;

  const DistrictState({this.districts, this.error});

  @override
  List<Object?> get props => [districts, error];
}

final class DistrictInitial extends DistrictState {}

final class GetDistrictSuccess extends DistrictState {
  const GetDistrictSuccess(List<DistrictEntity> districts)
      : super(districts: districts);
}

final class GetDistrictFail extends DistrictState {
  const GetDistrictFail(DioException e) : super(error: e);
}
