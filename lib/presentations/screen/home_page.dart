import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/presentations/common/colors.dart' as colors;
import 'package:personal_manager/presentations/screen/home_view.dart';

import '../../logic_bussiness/home/category/bloc/category_bloc.dart';
import '../../logic_bussiness/home/home/home_bloc.dart';
import 'statistical/category_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// final List<Widget> _pages = List.generate(4, (index) => const SizedBox());
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
// int _page = 0;

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final screens = [
    BlocProvider(
      create: (context) => HomeBloc()..add(HomeViewLoaded()),
      child: const HomeView(),
    ),
    // SizedBox(
    //   child: Text('1'),
    // ),
    BlocProvider(
      create: (context) => CategoryBloc()..add(CategoryViewLoaded()),
      child: CategoryView(),
    ),
    SizedBox(
      child: Text('3'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: screens[_selectedIndex],
        ),
      ),

      /*  IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ), */
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: colors.defaultColor1),
          Icon(Icons.add_chart_outlined, size: 30, color: colors.defaultColor1),
          Icon(Icons.person, size: 30, color: colors.defaultColor1),
          // Icon(Icons.call_split, size: 30, color: colors.defaultColor1),
          // Icon(Icons.perm_identity, size: 30, color: colors.defaultColor1),
        ],
        color: colors.defaultColor2,
        buttonBackgroundColor: colors.defaultColor2,
        backgroundColor: colors.defaultColor1,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: _selectedPage,
        letIndexChange: (index) => true,
      ),
    );
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
      // switch (index) {
      //   case constants.homeBottomNavigation:
      //     _pages.insert(index, _buildHomeWidget(context));

      //     break;
      //   case constants.summaryBottomNavigation:
      //     _pages.insert(index, _build2Widget(context));
      //     break;
      //   case constants.settingBottomNavigation:
      //     _pages.insert(index, _buildSettingWidget(context));
      //     break;

      //   default:
      // }
    });
  }

  _buildHomeWidget(BuildContext context) => BlocProvider(
        create: (context) => HomeBloc()..add(HomeViewLoaded()),
        child: const HomeView(),
      );
  _build2Widget(BuildContext context) => const SizedBox(
        child: Text('2'),
      );
  _buildSettingWidget(BuildContext context) => const SizedBox(
        child: Text('3'),
      );
}
