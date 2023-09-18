import 'package:flutter/material.dart';

import 'data/services/injection/injection.dart';
import 'data/services/navigator/navigator.dart';
import 'data/services/navigator/generate_route.dart' as router;

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
        home: const HomePage(),    navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,);
        
  }
}
