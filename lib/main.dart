import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/controllers/auth.controller.dart';
import 'package:frontend/controllers/cart.controller.dart';
import 'package:frontend/helpers/connectivity.helper.dart';
import 'package:frontend/views/splash.view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resize/resize.dart';

void main() async {
  runApp(const MyApp());
  await Hive.initFlutter();
  await Hive.openBox('temp');
  Get.put(ConnectivityController());
  Get.put(CartController());
  Get.put(AuthenticationController());
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
          home: const Splash());
    });
  }
}
