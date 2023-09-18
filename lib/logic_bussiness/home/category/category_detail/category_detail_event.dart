// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_detail_bloc.dart';

class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object> get props => [];
}

class CategoryDetailViewLoaded extends CategoryDetailEvent {
  final ExpensePurpose item;
  CategoryDetailViewLoaded({
    required this.item,
  });
  @override
  // TODO: implement props
  List<Object> get props => [item];
}

class CategoryDetailAddDetail extends CategoryDetailEvent {
  final double fee;
  final String name;
  final String memo;
  const CategoryDetailAddDetail(
      {required this.fee, required this.name, required this.memo});
  @override
  // TODO: implement props
  List<Object> get props => [fee, name, memo];
}
