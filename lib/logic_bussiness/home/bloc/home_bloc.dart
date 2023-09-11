// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:personal_manager/data/model/home/expense_purpose.dart';
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
      TotalIncome totalIncome = TotalIncome();
      if (data != null) {
        List<TotalIncome> totalIncomes = data.cast<TotalIncome>();
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
          totalIncome = a.last;
        }
      }
      List<ExpensePurpose> itemTest = [
        ExpensePurpose(
            id: 1, name: 'Còn lại', totalExpense: totalIncome.totalIncome),
      ];
      Map<String, double> dataMap = {};

      for (var element in itemTest) {
        final planets = <String, double>{element.name!: element.totalExpense!};
        dataMap.addAll(planets);
      }

      emit(HomeSuccess(
          purposeList: itemTest, maps: dataMap, totalIncome: totalIncome));
    } catch (e) {
      print(e.toString());
    }
  }

  void _mapChangePercentToState(HomeChangePercent event, emit) {
    try {
      final currentState = state;
      if (currentState is HomeSuccess) {
        emit(HomeLoading());
        final dataMap = currentState.maps;
        List<ExpensePurpose> itemTest = currentState.purposeList;
        final newItem = <String, double>{event.item.name!: event.item.totalExpense!};
        itemTest.add(event.item);
        dataMap.addAll(newItem);
        emit(currentState.copyWith(maps: dataMap, purposeList: itemTest));
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

//lại mở
        final box2 = await Hive.openBox(KeyBox.boxTotalIncome);

        final data2 = await box2.get(KeyName.totalIncome);

        if (data2 != null) {
          List<TotalIncome> totalIncomes = data.cast<TotalIncome>();
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

        emit(currentState.copyWith(totalIncome: newItem));
      }
    } catch (e) {}
  }
}
