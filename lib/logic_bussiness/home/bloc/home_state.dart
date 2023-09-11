// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final TotalIncome totalIncome;
  final List<ExpensePurpose> purposeList;
  final Map<String, double> maps;
  const HomeSuccess({
    required this.totalIncome,
    required this.purposeList,
    required this.maps,
  });
  @override
  List<Object> get props => [purposeList, maps, totalIncome];

  HomeSuccess copyWith({
    List<ExpensePurpose>? purposeList,
    Map<String, double>? maps,
    TotalIncome? totalIncome,
  }) {
    return HomeSuccess(
      purposeList: purposeList ?? this.purposeList,
      maps: maps ?? this.maps,
      totalIncome: totalIncome ?? this.totalIncome,
    );
  }
}

class HomeFailure extends HomeState {}
