part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends HomeEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
}
