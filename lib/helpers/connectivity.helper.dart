import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
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

  Future<ConnectivityResult> getConnectivityStatus() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult;
  }
}
