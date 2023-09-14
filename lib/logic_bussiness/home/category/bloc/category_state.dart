// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final TotalIncome totalIncome;
  final List<ExpensePurpose> expensePurposeList;
  const CategorySuccess({
    required this.totalIncome,
    required this.expensePurposeList,
  });
  @override
  // TODO: implement props
  List<Object> get props => [expensePurposeList, totalIncome];
}

class CategoryFailure extends CategoryState {}
