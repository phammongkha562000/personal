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
      List<ExpensePurpose> itemTest = [];
      Map<String, double> dataMap = {};

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
          itemTest = [
            ExpensePurpose(
                id: 1,
                name: 'Còn lại',
                totalExpense: totalIncome.totalIncome,
                idTotalIncome: totalIncome.id!),
          ];
          dataMap = {};

          for (var element in itemTest) {
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
        // List<ExpensePurpose> itemTestNew = [];

        itemTest.add(event.item);

        // itemTestNew = itemTest
        //     .map((e) => e.copyWith(
        //         totalExpense:
        //             e.totalExpense! / currentState.totalIncome.totalIncome! * 100))
        //     .toList();
        double sum = 0;
        for (var element in itemTest) {
          if (element.id != 1) {
            sum += element.totalExpense!;
          }
        }
          final itemTestNew2 = itemTest
              .map((e) => e.id == 1
                  ? e.copyWith(
                      totalExpense: (currentState.totalIncome.totalIncome! - sum))
                  : e)
              .toList();
          for (var element2 in itemTestNew2) {
            final newItem = <String, double>{
              element2.name!: element2.totalExpense!
            };
            dataMap.addAll(newItem);
          }
        emit(currentState.copyWith(maps: dataMap, purposeList: itemTestNew2));
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
