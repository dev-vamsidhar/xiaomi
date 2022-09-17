import 'package:frontend/helpers/apicalls.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEmployeeOrderFromDb();
  }

  List pastorder = [];
  Future getEmployeeOrderFromApi() async {
    try {
      String miid = await getKey(key: "miid");
      Map<String, dynamic> res =
          await postCall(postUrlpath: "app/getorders", body: {"miid": miid});
      log("ok");
      if (res['status'] != null) {
        await setKey(key: "pastorders", value: res['data']);
      }
      getEmployeeOrderFromDb();
      update();
    } catch (e) {
      toast("Something went wrong while fetching order.Please try again later");
    }
  }

  Future getEmployeeOrderFromDb() async {
    bool hasdata = await haskey(key: "pastorders");
    if (hasdata) {
      pastorder = await getKey(key: "pastorders");
      log(pastorder);
      update();
    }
  }
}
