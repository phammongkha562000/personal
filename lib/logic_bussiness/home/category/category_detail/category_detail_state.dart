// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_detail_bloc.dart';

class CategoryDetailState extends Equatable {
  const CategoryDetailState();

  @override
  List<Object> get props => [];
}

class CategoryDetailInitial extends CategoryDetailState {}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailSuccess extends CategoryDetailState {
  final List<ExpensePurposeDetail> ePDetailList;
  final List<ExpensePurposeDetail> ePDetailListByEP;
  final ExpensePurpose item;
  const CategoryDetailSuccess(
      {required this.ePDetailList,
      required this.item,
      required this.ePDetailListByEP});
  @override
  // TODO: implement props
  List<Object> get props => [ePDetailList, item, ePDetailListByEP];

  CategoryDetailSuccess copyWith(
      {List<ExpensePurposeDetail>? ePDetailList,
      ExpensePurpose? item,
      List<ExpensePurposeDetail>? ePDetailListByEP}) {
    return CategoryDetailSuccess(
      ePDetailList: ePDetailList ?? this.ePDetailList,
      ePDetailListByEP: ePDetailListByEP ?? this.ePDetailListByEP,
      item: item ?? this.item,
    );
  }
}

class CategoryDetailFailure extends CategoryDetailState {}
