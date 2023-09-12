// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final TotalIncome? totalIncome;
  final List<ExpensePurpose> expensePurposeList;
  final Map<String, double> dataMap;
  const HomeSuccess({
    required this.totalIncome,
    required this.expensePurposeList,
    required this.dataMap,
  });
  @override
  List<Object?> get props => [expensePurposeList, dataMap, totalIncome];

  HomeSuccess copyWith({
    List<ExpensePurpose>? expensePurposeList,
    Map<String, double>? dataMap,
    TotalIncome? totalIncome,
  }) {
    return HomeSuccess(
      expensePurposeList: expensePurposeList ?? this.expensePurposeList,
      dataMap: dataMap ?? this.dataMap,
      totalIncome: totalIncome ?? this.totalIncome,
    );
  }
}

class HomeFailure extends HomeState {}
