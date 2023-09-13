import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/data/model/home/total_income.dart';
import 'package:personal_manager/logic_bussiness/home/bloc/home_bloc.dart';
import 'package:personal_manager/presentations/common/assets.dart' as assets;
import 'package:personal_manager/presentations/common/colors.dart' as colors;
import 'package:personal_manager/presentations/components/appbar_radius.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:math' as math;
import '../../data/model/home/expense_purpose.dart';
import '../../data/shared/utils/format_number.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

final colorList = <Color>[
  const Color(0xfffdcb6e),
  const Color(0xff0984e3),
  const Color(0xfffd79a8),
  const Color(0xffb00020),
  const Color(0xff6c5ce7),
  const Color(0xff03ffcd),
  const Color(0xff37474F),
  const Color(0xff61d800),
  const Color(0xff4E342E)
];

class HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _totalIncomeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarRadius(
        height: 120,
        child: Text(
          'Create a new chart'.toUpperCase(),
          style: const TextStyle(
              color: colors.defaultColor1, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeSuccess) {
          state.totalIncome != null
              ? {
                  _totalIncomeController.text =
                      state.totalIncome!.totalIncome.toString()
                }
              : {};
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              assets.kIconBook,
              fit: BoxFit.cover,
            ),
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              color: colors.lavender,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Còn lại: ${state.expensePurposeList.where((element) => element.id == 1).single.totalExpense}',
                        style: const TextStyle(
                            color: colors.spanishLavender,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildForm(state: state),
                    state.totalIncome == null
                        ? const SizedBox()
                        : PieChart(
                            // totalValue: state.totalIncome.totalIncome,

                            dataMap: state.dataMap,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            // chartLegendSpacing: 32,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText:
                                state.totalIncome!.totalIncome.toString(),
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          ),
                  ],
                ),
              ),
            )
          ]);
        }
        return CircularProgressIndicator();
      }),
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: 0,
      //   height: 60.0,
      //   items: const <Widget>[
      //     Icon(Icons.home, size: 30, color: colors.defaultColor1),
      //     Icon(Icons.add_chart_outlined, size: 30, color: colors.defaultColor1),
      //     Icon(Icons.person, size: 30, color: colors.defaultColor1),
      //     // Icon(Icons.call_split, size: 30, color: colors.defaultColor1),
      //     // Icon(Icons.perm_identity, size: 30, color: colors.defaultColor1),
      //   ],
      //   color: colors.defaultColor2,
      //   buttonBackgroundColor: colors.defaultColor2,
      //   backgroundColor: colors.defaultColor1,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 600),
      //   onTap: (index) {
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // ),
    );
  }

  Widget _buildForm({required HomeSuccess state}) {
    return state.dataMap.isEmpty
        ? Row(
            children: [
              Expanded(
                flex: 7,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [NumberFormatter.formatMoney],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  controller: _totalIncomeController,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                            HomeAddTotalIncome(
                                totalIncome: double.parse(_totalIncomeController
                                    .text
                                    .replaceAll(',', ''))));
                      },
                      child: const Text('Add total')),
                ),
              )
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text('Purpose'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: colors.defaultColor1)),
                      ),
                      controller: _nameController,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [NumberFormatter.formatMoney],
                      decoration: InputDecoration(
                        label: Text('Money'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: colors.defaultColor1)),
                      ),
                      controller: _percentController,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 24),
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeChangePercent(
                          item: ExpensePurpose(
                              id: state.expensePurposeList.length + 1,
                              name: _nameController.text,
                              idTotalIncome: state.totalIncome!.id,
                              totalExpense: double.parse(_percentController.text
                                  .replaceAll(',', '')))));
                    },
                    child: Text('Add expense purpose')),
              ),
            ],
          );
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
