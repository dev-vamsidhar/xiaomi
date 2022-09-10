import 'package:frontend/constants/server.constants.dart';
import 'package:frontend/helpers/apicalls.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
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
    Map<String, dynamic> data =
        await postCall(postUrlpath: loginpath, body: body);
    if (data.isNotEmpty) {
      if (data.containsKey("miid")) {
        await setKey(key: 'token', value: data['token']);
        toast(data['status']);
        dismissloading();
        Get.offAll(StoreDetails());
        return;
      }
      dismissloading();
      toast(data['status']);
      return;
    }
  }
}
