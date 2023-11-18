// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'provider_bloc.dart';

abstract class ProviderEvent extends Equatable {
  const ProviderEvent();

  @override
  List<Object> get props => [];
}

class GetProviderEvent extends ProviderEvent {
  final String providerId;
  const GetProviderEvent({
    required this.providerId,
  });
}
