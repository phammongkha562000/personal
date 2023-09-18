// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:personal_manager/data/model/home/expense_purpose.dart';
import 'package:personal_manager/data/model/home/expense_purpose_detail.dart';
import 'package:personal_manager/data/model/home/total_income.dart';
import 'package:personal_manager/data/shared/utils/date/date_format/datetime_format.dart';

import '../../../data/services/hive/hive.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeViewLoaded>(_mapViewLoadedToState);
    on<HomeChangePercent>(_mapChangePercentToState);
    on<HomeAddTotalIncome>(_mapAddTotalToState);
  }
  Future<void> _mapViewLoadedToState(HomeViewLoaded event, emit) async {
    emit(HomeLoading());
    try {
      final box = await Hive.openBox(KeyBox.boxTotalIncome);
      final data = await box.get(KeyName.totalIncome);
      TotalIncome? totalIncome;
      List<ExpensePurpose> expensePurposeList = [];
      Map<String, double> dataMap = {};

      if (data != null) {
        List<TotalIncome> totalIncomes = data.cast<TotalIncome>();
        List<TotalIncome> currentTotalIncomes = totalIncomes
            .where((element) =>
                FormatDateConstants.convertUTCtoDateTime(element.dateTime!)
                        .year ==
                    DateTime.now().year &&
                FormatDateConstants.convertUTCtoDateTime(element.dateTime!)
                        .month ==
                    DateTime.now().month)
            .toList();
        if (currentTotalIncomes != []) {
          totalIncome = currentTotalIncomes.last;
          final boxExpense = await Hive.openBox(KeyBox.boxExpensePurpose);
          final dataExpense = await boxExpense.get(KeyName.expensePurposeKey);
          if (dataExpense != null) {
            List<ExpensePurpose> expenseList =
                dataExpense.cast<ExpensePurpose>();
            List<ExpensePurpose> currentExpenseInMonth = expenseList
                .where((element) => element.idTotalIncome == totalIncome!.id)
                .toList();
            expensePurposeList = currentExpenseInMonth;
          } else {
            expensePurposeList = [
              ExpensePurpose(
                  id: 1,
                  name: 'Còn lại',
                  totalExpense: totalIncome.totalIncome,
                  idTotalIncome: totalIncome.id!),
            ];
          }
          for (var element in expensePurposeList) {
            final planets = <String, double>{
              element.name!: element.totalExpense!
            };
            dataMap.addAll(planets);
          }
        } else {
          dataMap = {};
        }
      }

      emit(HomeSuccess(
          expensePurposeList: expensePurposeList,
          dataMap: dataMap,
          totalIncome: totalIncome));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _mapChangePercentToState(HomeChangePercent event, emit) async {
    try {
      final currentState = state;
      if (currentState is HomeSuccess) {
        emit(HomeLoading());
        final dataMap = currentState.dataMap;
        List<ExpensePurpose> expensePurposeList =
            currentState.expensePurposeList;

        expensePurposeList.add(event.item);

        double sum = 0;
        for (var element in expensePurposeList) {
          if (element.id != 1) {
            sum += element.totalExpense!;
          }
        }
        final itemTestNew2 = expensePurposeList
            .map((e) => e.id == 1
                ? e.copyWith(
                    totalExpense:
                        (currentState.totalIncome!.totalIncome! - sum))
                : e)
            .toList();
        for (var element2 in itemTestNew2) {
          final newItem = <String, double>{
            element2.name!: element2.totalExpense!
          };
          dataMap.addAll(newItem);
        }
        int date = DateTime.now().millisecondsSinceEpoch;

        final box = await Hive.openBox(KeyBox.boxExpensePurpose);
        box.put(KeyName.expensePurposeKey, itemTestNew2);
        final boxDetail = await Hive.openBox(KeyBox.boxEPDetail);
        final dataDetail = await boxDetail.get(KeyName.ePDetailKey);
        ExpensePurposeDetail itemDetail;
        List<ExpensePurposeDetail> detailList = [];
        if (dataDetail != null) {
          detailList = dataDetail.cast<ExpensePurposeDetail>();
          itemDetail = ExpensePurposeDetail(
              id: detailList.length + 1,
              name: 'Còn lại',
              fee: event.item.totalExpense,
              idExpensePurpose: event.item.id,
              dateTime: date);
          detailList.add(itemDetail);
        } else {
          itemDetail = ExpensePurposeDetail(
              id: 1,
              name: 'Còn lại',
              fee: event.item.totalExpense,
              idExpensePurpose: event.item.id,
              dateTime: date);
          detailList.add(itemDetail);
        }
        boxDetail.put(KeyName.ePDetailKey, detailList);
        emit(currentState.copyWith(
          dataMap: dataMap,
          expensePurposeList: itemTestNew2,
        ));
      }
    } catch (e) {}
  }

  Future<void> _mapAddTotalToState(HomeAddTotalIncome event, emit) async {
    try {
      final currentState = state;
      if (currentState is HomeSuccess) {
        emit(HomeLoading());
        final box = await Hive.openBox(KeyBox.boxTotalIncome);
        final data = await box.get(KeyName.totalIncome);
        int date = DateTime.now().millisecondsSinceEpoch;

        List<TotalIncome> totalIncomes = [];
        TotalIncome newItem = TotalIncome();
        if (data != null) {
          List<TotalIncome> lengthList = data.cast<TotalIncome>();
          newItem = TotalIncome(
              id: lengthList.length + 1,
              dateTime: date,
              totalIncome: event.totalIncome);
        } else if (data == null) {
          newItem = TotalIncome(
              id: 1, dateTime: date, totalIncome: event.totalIncome);
        }
        totalIncomes.add(newItem);
        box.put(KeyName.totalIncome, totalIncomes);
        log('HIVE - SAVE ${KeyName.totalIncome}');

        //sao khi add, mở lại
        final box2 = await Hive.openBox(KeyBox.boxTotalIncome);

        final data2 = await box2.get(KeyName.totalIncome);

        if (data2 != null) {
          List<TotalIncome> totalIncomes = data2.cast<TotalIncome>();
          List<TotalIncome> a = totalIncomes
              .where((element) =>
                  FormatDateConstants.convertUTCtoDateTime(element.dateTime!)
                          .year ==
                      DateTime.now().year &&
                  FormatDateConstants.convertUTCtoDateTime(element.dateTime!)
                          .month ==
                      DateTime.now().month)
              .toList();
          if (a != []) {
            newItem = a.last;
          }
        }
        List<ExpensePurpose> expensePurposeList = [];
        Map<String, double> dataMap = {};
        expensePurposeList = [
          ExpensePurpose(
              id: 1,
              name: 'Còn lại',
              totalExpense: newItem.totalIncome,
              idTotalIncome: newItem.id),
        ];
        final boxExpense = await Hive.openBox(KeyBox.boxExpensePurpose);
        boxExpense.put(KeyName.expensePurposeKey, expensePurposeList);

        for (var element in expensePurposeList) {
          final planets = <String, double>{
            element.name!: element.totalExpense!
          };
          dataMap.addAll(planets);
        }

        emit(currentState.copyWith(
            totalIncome: newItem,
            dataMap: dataMap,
            expensePurposeList: expensePurposeList));
      }
    } catch (e) {}
  }
}
