part of 'district_bloc.dart';

abstract class DistrictEvent extends Equatable {
  const DistrictEvent();

  @override
  List<Object> get props => [];
}

class GetDistricts extends DistrictEvent {
  const GetDistricts();
}
