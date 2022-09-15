import 'package:frontend/constants/server.constants.dart';
import 'package:frontend/controllers/cart.controller.dart';
import 'package:frontend/controllers/orders.controller.dart';
import 'package:frontend/helpers/apicalls.dart';
import 'package:frontend/helpers/connectivity.helper.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/views/home.view.dart';
import 'package:frontend/views/storedetails.view.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void signInWithEmail(
      {required String email, required String password}) async {
    Map<String, String> body = {"miid": email, "password": password};
    loading();
    bool hasinternet = await ConnectivityController().checkdataconnection();
    if (!hasinternet) {
      toast(
          "Please internet connection. Internet is required at the time of login");
      return;
    }
    Map<String, dynamic> data =
        await postCall(postUrlpath: loginpath, body: body);
    if (data.isNotEmpty) {
      if (data.containsKey("miid")) {
        await setKey(key: 'token', value: data['token']);
        await setKey(key: 'miid', value: data['miid']);
        await getuserinitialdata();
        String storename = await getKey(key: "storename");
        log(storename);
        if (storename.isNotEmpty) {
          toast(data['status']);
          dismissloading();
          Get.offAll(HomePage());
          return;
        }
        dismissloading();
        Get.offAll(const StoreDetails());
        return;
      }
      dismissloading();
      toast(data['status']);
      return;
    }
    dismissloading();
    toast("Something went wrong. Please try again later");
  }

  void updateuser(
      {required String storename,
      required String storetype,
      required String posid}) async {
    try {
      loading();
      String miid = await getKey(key: "miid");
      var res = await postCall(postUrlpath: "app/updatestoreprofile", body: {
        "miid": miid,
        "storename": storename,
        "storetype": storetype,
        "posid": posid
      });
      setKey(key: "storename", value: storename);
      setKey(key: "storetype", value: storetype);
      setKey(key: "posid", value: posid);

      if (res["status"] != null) {
        dismissloading();
        Get.offAll(HomePage());
        toast(res['status']);
        return;
      }
      dismissloading();
      toast("Something went wrong");
    } catch (e) {
      log(e);
      toast("Something went wrong at our end. Please try again later");
    }
  }

  Future getuserinitialdata() async {
    ///Get cart data
    Get.find<CartController>().getCartitemsfromapi();

    ///Get profile data
    String miid = await getKey(key: "miid");
    var res =
        await postCall(postUrlpath: "app/getprofile", body: {"miid": miid});
    log(res);
    if (res['status'] != null) {
      if (res["data"].length > 0) {
        setKey(key: "storename", value: res["data"][0]['storename']);
        setKey(key: "storetype", value: res["data"][0]['storetype']);
        setKey(key: "posid", value: res["data"][0]['posid']);
      }
    } else {
      toast("Something went wrong while fetching data. Please try again later");
    }

    ///Get past order
    await Get.find<OrderController>().getEmployeeOrderFromApi();

    ///
  }
}
