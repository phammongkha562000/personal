import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/logic_bussiness/home/bloc/home_bloc.dart';
import 'package:personal_manager/presentations/common/colors.dart' as colors;
import 'package:personal_manager/presentations/common/constants.dart'
    as constants;
import 'package:personal_manager/presentations/screen/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;
final List<Widget> _pages = List.generate(4, (index) => SizedBox());
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
int _page = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
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
        animationDuration: Duration(milliseconds: 600),
        onTap: _selectedPage,
        letIndexChange: (index) => true,
      ),
    );
  }

  void _selectedPage(int index) {
    setState(() {
      switch (index) {
        case constants.homeBottomNavigation:
          _pages.insert(index, _buildHomeWidget(context));

          break;
        case constants.summaryBottomNavigation:
          _pages.insert(index, _build2Widget(context));
          break;
        case constants.settingBottomNavigation:
          _pages.insert(index, _buildSettingWidget(context));
          break;

        default:
      }
    });
  }

  _buildHomeWidget(BuildContext context) => BlocProvider(
        create: (context) => HomeBloc()..add(HomeViewLoaded()),
        child: HomeView(),
      );
  _build2Widget(BuildContext context) => SizedBox(
        child: Text('2'),
      );
  _buildSettingWidget(BuildContext context) => SizedBox(
        child: Text('3'),
      );
}
