part of 'report_provider_bloc.dart';

abstract class ReportProviderState extends Equatable {
  final DioException? error;
  const ReportProviderState({this.error});

  @override
  List<Object?> get props => [error];
}

final class ReportProviderInitial extends ReportProviderState {}

final class ReportProviderSuccess extends ReportProviderState {}

final class ReportProviderFail extends ReportProviderState {
  const ReportProviderFail(DioException e) : super(error: e);
}
