part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final int tabIndex;

  const HomeState({required this.tabIndex});
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial({required super.tabIndex});
}
