import 'package:flutter/material.dart';

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
        home: const HomePage());
  }
}
