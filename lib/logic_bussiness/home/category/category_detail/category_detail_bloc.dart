import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:personal_manager/data/model/home/expense_purpose.dart';
import 'package:personal_manager/data/model/home/expense_purpose_detail.dart';
import 'package:personal_manager/data/services/hive/hive.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc() : super(CategoryDetailInitial()) {
    on<CategoryDetailViewLoaded>(_mapViewLoadedToState);
    on<CategoryDetailAddDetail>(_mapAddDetailToState);
  }
  Future<void> _mapViewLoadedToState(
      CategoryDetailViewLoaded event, emit) async {
    try {
      final boxDetail = await Hive.openBox(KeyBox.boxEPDetail);
      final dataDetail = await boxDetail.get(KeyName.ePDetailKey);
      List<ExpensePurposeDetail> ePDetailList = [];
      List<ExpensePurposeDetail> ePDetailByEPList = [];

      if (dataDetail != null) {
        ePDetailList = dataDetail.cast<ExpensePurposeDetail>();
        ePDetailByEPList = ePDetailList
            .where((element) => element.idExpensePurpose == event.item.id)
            .toList();
      }
      emit(CategoryDetailSuccess(
          ePDetailList: ePDetailList,
          item: event.item,
          ePDetailListByEP: ePDetailByEPList)); 
    } catch (e) {}
  }

  Future<void> _mapAddDetailToState(CategoryDetailAddDetail event, emit) async {
    try {
      final currentState = state;
      if (currentState is CategoryDetailSuccess) {
        emit(CategoryDetailLoading());
        int date = DateTime.now().millisecondsSinceEpoch;

        final newDetail = ExpensePurposeDetail(
            id: currentState.ePDetailList.length + 1,
            fee: event.fee,
            memo: event.memo,
            name: event.name,
            idExpensePurpose: currentState.item.id,
            dateTime: date);
        final ePDetailList = currentState.ePDetailList;
        ePDetailList.add(newDetail);
        final boxDetail = await Hive.openBox(KeyBox.boxEPDetail);
        boxDetail.put(KeyName.ePDetailKey, ePDetailList);
        final ePDetailByEPList = ePDetailList
            .where(
                (element) => element.idExpensePurpose == currentState.item.id)
            .toList();
        emit(currentState.copyWith(
            ePDetailList: ePDetailList, ePDetailListByEP: ePDetailByEPList));
      }
    } catch (e) {}
  }
}
