import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/views/storedetails.view.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void signInWithEmail(
      {required String email, required String password}) async {
    await setKey(key: 'token', value: "something is saved");
    Get.offAll(StoreDetails());
  }
}
