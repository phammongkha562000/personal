import 'package:flutter/material.dart';
import 'package:personal_manager/my_app.dart';

import 'data/services/hive/hive_helper.dart';

Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // *Init Hive

  await HiveBoxHelper.initHive();
  runApp(const MyApp());
}
