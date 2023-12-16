// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tag_popular_bloc.dart';

abstract class TagPopularState extends Equatable {
  final List<dynamic>? tags;
  final DioException? error;
  const TagPopularState({
    this.tags,
    this.error,
  });

  @override
  List<Object> get props => [];
}

final class TagPopularInitial extends TagPopularState {}

final class GetPopularTagSuccess extends TagPopularState {
  const GetPopularTagSuccess(List<dynamic> tags) : super(tags: tags);
}

final class GetPopularTagFail extends TagPopularState {
  const GetPopularTagFail(DioException e) : super(error: e);
}
