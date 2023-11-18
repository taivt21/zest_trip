// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'provider_bloc.dart';

abstract class ProviderState extends Equatable {
  final ProviderEntity? providerEntity;
  final DioException? error;
  const ProviderState({
    this.providerEntity,
    this.error,
  });

  @override
  List<Object?> get props => [providerEntity, error];
}

final class ProviderInitial extends ProviderState {}

final class GetInfoProviderSuccess extends ProviderState {
  const GetInfoProviderSuccess(ProviderEntity providerEntity)
      : super(providerEntity: providerEntity);
}

final class GetInfoProviderFail extends ProviderState {
  const GetInfoProviderFail(DioException e) : super(error: e);
}
