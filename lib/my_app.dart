import 'package:flutter/material.dart';
import 'package:personal_manager/presentations/screen/home_view.dart';
import 'package:pie_chart/pie_chart.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor:  Color(0xFF4e4e4e),
        scaffoldBackgroundColor: Color(0xFF4e4e4e),),
      home: const HomeView(),
    );
  }
}
