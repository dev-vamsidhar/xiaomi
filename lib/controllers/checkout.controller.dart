import 'package:flutter/material.dart';
import 'package:frontend/controllers/orders.controller.dart';
import 'package:frontend/helpers/apicalls.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/model/cart.model.dart';
import 'package:frontend/model/ordermodel.dart';
import 'package:frontend/views/auth.view.dart';
import 'package:get/get.dart';

import '../helpers/hive.helper.dart';

class CheckoutController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getmiid();
    super.onInit();
  }

  String mmid = "";
  void getmiid() async {
    mmid = await getKey(key: "miid");
    if (mmid.isEmpty) {
      Get.offAll(Auth());
      return;
    }
    update();
  }

  Future saveorder(CartModel cartdata, String fullname, String phone,
      String email, OrderModel ordermodel) async {
    try {
      loading();
      Map<String, dynamic> body = {};
      body.addAll(cartdata.tojson(cartdata));
      body['name'] = fullname;
      body['phone'] = phone;
      body['email'] = email;
      body['miid'] = await getKey(key: "miid");
      Map<String, dynamic> paymentdetails = ordermodel.tojson(ordermodel);
      bool hasdata = await haskey(key: "pastorders");
      if (hasdata) {
        List pastorder = await getKey(key: "pastorders");
        pastorder.add(body);
        await setKey(key: "pastorders", value: pastorder);
        Get.find<OrderController>().pastorder = pastorder;
        update();
      }
      await postCall(postUrlpath: "app/createorder", body: body);
      dismissloading();
    } catch (e) {
      log(e);
      dismissloading();
      toast("Something went wrong at our side. Please try again later");
    }
  }
}
