// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  final String? url;
  final DioException? error;
  const BannerState({
    this.url,
    this.error,
  });

  @override
  List<Object?> get props => [url, error];
}

final class BannerInitial extends BannerState {}

final class GetBannerSuccess extends BannerState {
  const GetBannerSuccess(String url) : super(url: url);
}

final class GetBannerFail extends BannerState {
  const GetBannerFail(DioException e) : super(error: e);
}
