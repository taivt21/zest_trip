part of 'report_provider_bloc.dart';

abstract class ReportProviderEvent extends Equatable {
  const ReportProviderEvent();

  @override
  List<Object> get props => [];
}

final class ReportProvider extends ReportProviderEvent {
  final String providerId;
  final String reason;
  final String type;
  const ReportProvider(
      {required this.providerId, required this.reason, required this.type});
}
