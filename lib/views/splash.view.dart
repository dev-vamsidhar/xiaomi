import 'package:flutter/material.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/views/home.view.dart';
import 'package:frontend/views/storedetails.view.dart';
import 'package:frontend/views/auth.view.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    String token = await getKey(key: "token");
    log("Token is $token", Sevearity.low);
    if (token.isEmpty) {
      Get.offAll(Auth());
      return;
    }
    String storename = await getKey(key: "storename");
    if (storename.isEmpty) {
      Get.offAll(StoreDetails());
      return;
    }
    Get.offAll(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/logo.png",
              height: Get.height / 5,
              width: Get.width / 5,
            )),
          ]),
    );
  }
}
