import 'package:frontend/constants/server.constants.dart';
import 'package:frontend/helpers/apicalls.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/model/cart.model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  List<CartModel> cartitems = [];
  Future getCartItems() async {
    cartitems.clear();
    Box box = await Hive.openBox("cart");
    Iterable<dynamic> keys = box.keys;
    for (var element in keys) {
      cartitems.add(CartModel.fromjson(box.get(element)));
    }

    log(cartitems);
    update();
  }

  Future addtoCart(CartModel item) async {
    loading();
    try {
      var uuid = const Uuid();
      String uid = uuid.v4();
      Map<String, dynamic> data = item.tojson(item);
      Box box = await Hive.openBox("cart");
      data['id'] = uid;
      data['miid'] = await getKey(key: "miid");
      await postCall(postUrlpath: addtocart, body: data);
      await box.put(uid, data);
      getCartItems();
      update();
      dismissloading();
      return;
    } catch (e) {
      dismissloading();
    }
  }

  Future getCartitemsfromapi() async {
    Box box = await Hive.openBox("cart");
    String mid = await getKey(key: "miid");
    var data =
        await postCall(postUrlpath: "app/getcartitems", body: {"miid": mid});
    if (data["status"] == "Cart data fetched sucessfully") {
      for (var element in data['data']) {
        await box.put(element['id'], element);
      }
    }
  }

  Future deleteCartItem(String key) async {
    loading();
    try {
      Box box = await Hive.openBox("cart");
      await box.delete(key);
      await getCartItems();
      await postCall(postUrlpath: "app/deletecart", body: {"id": key});
      update();
      dismissloading();
      return;
    } catch (e) {
      dismissloading();
      return;
    }
  }

  Future deleteall() async {
    Box box = await Hive.openBox("cart");
    box.clear();
    await getCartItems();
    update();
    log("delete");
  }
}
