import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as diopack;
import 'package:frontend/helpers/logger.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void onInit() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        //Implement no internet
      } else {
        //Implement has internet
      }
      log(result, Sevearity.high);
    });
    super.onInit();
  }

  Future<bool> getConnectivityStatus() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      bool connection = await checkdataconnection();
      return connection;
    }
  }

  Future<bool> checkdataconnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log(result);
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
