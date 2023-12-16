part of 'tag_popular_bloc.dart';

abstract class TagPopularEvent extends Equatable {
  const TagPopularEvent();

  @override
  List<Object> get props => [];
}

class GetPopularTag extends TagPopularEvent {
  const GetPopularTag();
}
