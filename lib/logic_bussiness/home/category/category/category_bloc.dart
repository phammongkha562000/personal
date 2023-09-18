import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:personal_manager/data/model/home/total_income.dart';
import 'package:personal_manager/presentations/screen/statistical/category_view.dart';

import '../../../../data/model/home/expense_purpose.dart';
import '../../../../data/services/hive/hive.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryViewLoaded>(_mapViewLoadedToState);
  }
  Future<void> _mapViewLoadedToState(CategoryViewLoaded event, emit) async {
    emit(CategoryLoading());
    try {
      final boxTotal = await Hive.openBox(KeyBox.boxTotalIncome);
      final dataTotal = boxTotal.get(KeyName.totalIncome);
      final boxExpense = await Hive.openBox(KeyBox.boxExpensePurpose);
      final dataExpense = boxExpense.get(KeyName.expensePurposeKey);
      List<ExpensePurpose> expensePurposeList = [];
      if (dataExpense != null) {
        expensePurposeList = dataExpense.cast<ExpensePurpose>();
      }
      List<TotalIncome> totalIncomeList = dataTotal.cast<TotalIncome>();

      emit(CategorySuccess(
          expensePurposeList: expensePurposeList,
          totalIncome: totalIncomeList.first));
    } catch (e) {}
  }
}
