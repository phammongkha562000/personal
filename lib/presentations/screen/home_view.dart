import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/data/model/home/total_income.dart';
import 'package:personal_manager/logic_bussiness/home/bloc/home_bloc.dart';
import 'package:personal_manager/presentations/common/assets.dart' as assets;
import 'package:personal_manager/presentations/components/appbar_radius.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../data/model/home/expense_purpose.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

Map<String, double> dataMap = {
  "Nhà": 5,
  "Nấu ăn": 3,
  "Ăn ngoài": 2,
  "Lặt vặt": 2,
  "Mua sắm": 1,
  "Còn lại": 1,
};
final colorList = <Color>[
  const Color(0xfffdcb6e),
  const Color(0xff0984e3),
  const Color(0xfffd79a8),
  const Color(0xffe17055),
  const Color(0xff6c5ce7),
  const Color(0xff03ffcd),
];
ChartType? _chartType = ChartType.disc;
int _page = 0;
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

class HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200))
    ..addListener(() {
      // setState(() {});
    });
  late final animation = Tween<Matrix4>(
          begin: Matrix4.translationValues(-1, 48, 0), end: Matrix4.identity())
      .animate(controller);
  TextEditingController _totalIncomeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _percentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarRadius(
        height: 100,
        child: Text(
          'Khởi tạo'.toUpperCase(),
          textAlign: TextAlign.start,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            _totalIncomeController.text =
                state.totalIncome.totalIncome.toString();
            return SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      transform: animation.value,
                      // color: Colors.white,
                      duration: controller.duration!,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              assets.kIconBook,
                              fit: BoxFit.cover,
                            ),
                            ElevatedButton(
                              onPressed:
                                  controller.status == AnimationStatus.reverse
                                      ? () {
                                          controller.forward();
                                        }
                                      : () {
                                          controller.reverse();
                                        },
                              child: const Text("Create a new chart"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      transform: animation.value,
                      // color: Colors.white,
                      duration: controller.duration!,
                      child: controller.status == AnimationStatus.dismissed
                          ? Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 16),
                                child: Column(
                                  children: [
                                    _buildForm(state: state),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PieChart(
                                        dataMap: state.maps,
                                        animationDuration:
                                            const Duration(milliseconds: 1000),
                                        // chartLegendSpacing: 32,
                                        chartRadius:
                                            MediaQuery.of(context).size.width /
                                                3.2,
                                        colorList: colorList,
                                        initialAngleInDegree: 0,
                                        chartType: ChartType.ring,
                                        ringStrokeWidth: 32,
                                        centerText: state
                                            .totalIncome.totalIncome
                                            .toString(),
                                        legendOptions: const LegendOptions(
                                          showLegendsInRow: false,
                                          legendPosition: LegendPosition.right,
                                          showLegends: true,
                                          legendShape: BoxShape.circle,
                                          legendTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        chartValuesOptions:
                                            const ChartValuesOptions(
                                          showChartValueBackground: true,
                                          showChartValues: true,
                                          showChartValuesInPercentage: false,
                                          showChartValuesOutside: false,
                                          decimalPlaces: 1,
                                        ),
                                        // gradientList: ---To add gradient colors---
                                        // emptyColorGradient: ---Empty Color gradient---
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ]),
            );
          }
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.add_chart_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          // Icon(Icons.call_split, size: 30, color: Colors.white),
          // Icon(Icons.perm_identity, size: 30, color: Colors.white),
        ],
        color: Color(0xFF4e4e4e),
        buttonBackgroundColor: Color(0xFF4e4e4e),
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget _buildForm({required HomeSuccess state}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  controller: _totalIncomeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeAddTotalIncome(
                          totalIncome:
                              double.parse(_totalIncomeController.text)));
                    },
                    child: const Text('Add total')),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    controller: _nameController,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    controller: _percentController,
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(HomeChangePercent(
                    item: ExpensePurpose(
                        id: state.purposeList.length + 1,
                        name: _nameController.text,
                        idTotalIncome: state.totalIncome.id,
                        totalExpense: double.parse(_percentController.text))));
              },
              child: Text('Add expense purpose')),
        ],
      ),
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

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
