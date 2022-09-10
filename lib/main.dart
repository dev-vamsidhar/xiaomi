import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/helpers/connectivity.helper.dart';
import 'package:frontend/views/auth.view.dart';
import 'package:frontend/views/splash.view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:resize/resize.dart';

void main() async {
  runApp(const MyApp());
  var path = Directory.current.path;
  Hive.init(path);
  await Hive.openBox('temp');
  Get.put(ConnectivityController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return GetMaterialApp(
          title: 'Xiaomi',
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: Splash());
    });
  }
}
