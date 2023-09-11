import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'file_adapter/total_income_adapter.dart';
import 'hive_key/key_box.dart';

class HiveBoxHelper {
  // static final Logger _logger = Logger(GlobalApp.logz.toString());
  static initHive() async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS

    var path = directory?.path.toString() ?? '';

    Hive
      ..init(path)
      ..registerAdapter(TotalIncomeAdapter(0));
  }

  static closeHive() {
    Hive.close();
  }

  static deleteBox() async {
    try {
      Hive.deleteFromDisk();
      // _logger.info("DELETE BOX OK");
    } catch (e) {
      // _logger.severe("Error delete Box", e);
      log("ERRORROROR: $e");
    }
  }

  static deleteAllDataFromHive() async {
    try {
      for (var element in KeyBox.listBox) {
        var a = await Hive.openBox(element);
        await a.clear();
      }
      log('HIVE - Delete all data');
    } catch (e) {
      log("ERRORROROR: $e");
    }
  }
}
