import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

enum Sevearity { high, low, medium }

void log(data, [Sevearity type = Sevearity.high]) {
  if (type == Sevearity.high) {
    Logger().e(data);
  } else if (type == Sevearity.low) {
    Logger().v(data);
  } else {
    Logger().w(data);
  }
}

void toast(data) {
  EasyLoading.showToast(data, toastPosition: EasyLoadingToastPosition.bottom);
}

void loading({String status = "Loading..."}) {
  EasyLoading.show(status: status, indicator: CircularProgressIndicator());
}

void dismissloading() {
  EasyLoading.dismiss();
}
