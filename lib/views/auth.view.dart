import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/auth.controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../helpers/widgets.helper.dart';

class Auth extends StatelessWidget {
  Auth({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationController authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, charac) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                      8.0,
                    ) +
                    EdgeInsets.symmetric(horizontal: Get.width > 700 ? 90 : 0),
                child: Row(
                  mainAxisAlignment: Get.width > 700
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    Get.width > 700
                        ? SizedBox(
                            height: Get.width / 3,
                            child: Lottie.asset("assets/lotties/pos.json"))
                        : Container(),
                    form(),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  Widget proceedButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          authenticationController.signInWithEmail(
              email: emailController.text, password: passwordController.text);
        },
        child: Center(
          child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
              child:const Center(
                  child: Text(
                "Log in",
                style: TextStyle(color: Colors.white),
              ))),
        ),
      ),
    );
  }

  Widget form() {
    return Container(
      width: 280,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const[
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(1, 0))
          ]),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                height: 50,
              ),
            ),
          ),
          Column(
            children: [
              feild(controller: emailController, hintText: "Enter the MI Id"),
              feild(
                  controller: passwordController,
                  hintText: "Enter the password"),
            ],
          ),
          sh20,
          proceedButton(),
          sh20,
          sh10,
          const Center(
              child: Text(
            "Other Options",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )),
          sh10,
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () {},
                child:const Center(
                    child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                )),
              ))
        ],
      ),
    );
  }

}
