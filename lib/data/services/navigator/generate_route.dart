import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_manager/data/services/navigator/route_path.dart'
    as route;
import 'package:personal_manager/logic_bussiness/home/category/category_detail/category_detail_bloc.dart';
import 'package:personal_manager/presentations/common/strings.dart' as strings;
import 'package:personal_manager/presentations/common/key_params.dart'
    as key_params;

import 'package:personal_manager/presentations/screen/statistical/category_detail_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case route.categoryDetailRoute:
      final item = (settings.arguments as Map)[key_params.expenseItem];
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => CategoryDetailBloc()..add(CategoryDetailViewLoaded(item: item)),
                child: CategoryDetailView(item: item),
              ));

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('${strings.noPath} ${settings.name}')),
        ),
      );
  }
}
