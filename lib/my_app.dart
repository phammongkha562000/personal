import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/logic_bussiness/home/bloc/home_bloc.dart';
import 'package:personal_manager/presentations/screen/home_view.dart';
import 'package:pie_chart/pie_chart.dart';

import 'presentations/common/theme.dart';
import 'presentations/screen/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(primaryColor:  colors.defaultColor1,//0xFF4e4e4e
        //   scaffoldBackgroundColor: colors.defaultColor1,),
        home:
            HomePage() /* BlocProvider(
        create: (context) => HomeBloc()..add(HomeViewLoaded()),
        child: HomeView(),
      ), */
        );
  }
}
