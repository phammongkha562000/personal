import 'package:flutter/material.dart';
import 'package:personal_manager/my_app.dart';

import 'data/services/hive/hive_helper.dart';
import 'data/services/injection/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // *Init Hive
  configureInjection();
  await HiveBoxHelper.initHive();
  runApp(const MyApp());
}
