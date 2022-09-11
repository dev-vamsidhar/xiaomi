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
    var uuid = const Uuid();
    Map<String, dynamic> data = item.tojson(item);
    Box box = await Hive.openBox("cart");
    String uid = uuid.v4();
    data['id'] = uid;
    await box.put(uid, data);
    getCartItems();
    update();
    return;
  }

  Future deleteCartItem(String key) async {
    Box box = await Hive.openBox("cart");
    await box.delete(key);
    await getCartItems();
    update();
    return;
  }

  Future deleteall() async {
    Box box = await Hive.openBox("cart");
    box.clear();
    await getCartItems();
    update();
    log("delete");
  }
}
