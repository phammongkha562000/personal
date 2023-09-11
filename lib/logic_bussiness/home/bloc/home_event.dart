// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeViewLoaded extends HomeEvent {}
class HomeAddTotalIncome extends HomeEvent {
  final double totalIncome;
  const HomeAddTotalIncome({
    required this.totalIncome,
  });
  @override
  List<Object> get props => [totalIncome];
}
class HomeChangePercent extends HomeEvent {
  final ExpensePurpose item;
  const HomeChangePercent({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}
