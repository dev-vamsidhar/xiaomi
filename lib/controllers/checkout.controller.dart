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
      String email, OrderModel ordermodel) async {}
}
