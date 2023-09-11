import 'package:flutter/material.dart';
import 'package:personal_manager/presentations/components/appbar_radius.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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

class HomeViewState extends State<HomeView> {
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Create a new chart')))
            // PieChart(
            //   dataMap: dataMap,
            //   animationDuration: const Duration(milliseconds: 800),
            //   // chartLegendSpacing: 32,
            //   chartRadius: MediaQuery.of(context).size.width / 3.2,
            //   colorList: colorList,
            //   initialAngleInDegree: 0,
            //   chartType: ChartType.ring,
            //   ringStrokeWidth: 32,
            //   centerText: "HYBRID",
            //   legendOptions: const LegendOptions(
            //     showLegendsInRow: false,
            //     legendPosition: LegendPosition.right,
            //     showLegends: true,
            //     legendShape: BoxShape.circle,
            //     legendTextStyle: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white
            //     ),
            //   ),
            //   chartValuesOptions: const ChartValuesOptions(
            //     showChartValueBackground: true,
            //     showChartValues: true,
            //     showChartValuesInPercentage: false,
            //     showChartValuesOutside: false,
            //     decimalPlaces: 1,
            //   ),
            //   // gradientList: ---To add gradient colors---
            //   // emptyColorGradient: ---Empty Color gradient---
            // ),
          ]),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.add_chart_outlined, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          // Icon(Icons.call_split, size: 30, color: Colors.white),
          // Icon(Icons.perm_identity, size: 30, color: Colors.white),
        ],
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Color(0xFF4e4e4e),
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
}
