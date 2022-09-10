import 'package:get/get.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  Future getCartItems() async {}
  Future addtoCart() async {}
  Future deleteCartItem() async {}
}
