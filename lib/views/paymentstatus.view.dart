import 'package:flutter/material.dart';
import 'package:frontend/views/home.view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({Key? key, required this.paymentstatus})
      : super(key: key);
  final bool paymentstatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Container(
          child: Lottie.asset(
              paymentstatus
                  ? "assets/lotties/paymentsucessful.json"
                  : "assets/lotties/paymentfailed.json",
              height: Get.height / 3),
        )),
        InkWell(
          onTap: () {
            Get.offAll(HomePage());
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Go to HomePage",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
