import 'package:get/get.dart';
import 'common/bottom_menu/index.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'common/picture_aspect/get_an_instance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> getSDCardDir() async {
    Common().rootPath = (await getExternalStorageDirectory()).path;
  }

  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      }
      await getSDCardDir();
    } else if (Platform.isIOS) {
      await getSDCardDir();
    }
  }

  Future.wait([initializeDateFormatting("zh_CN", null), getPermission()])
      .then((result) {
    runApp(GetMaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: BottomMenuPage(),
    );
  }
}
