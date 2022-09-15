import 'package:flutter/material.dart';
import 'package:frontend/controllers/checkout.controller.dart';
import 'package:frontend/helpers/hive.helper.dart';
import 'package:frontend/helpers/logger.dart';
import 'package:frontend/helpers/widgets.helper.dart';
import 'package:frontend/model/cart.model.dart';
import 'package:frontend/views/payment.view.dart';
import 'package:get/get.dart';

class OrderCheckout extends StatelessWidget {
  const OrderCheckout({super.key, required this.cartdata});
  final CartModel cartdata;

  @override
  Widget build(BuildContext context) {
    CheckoutController checkoutController = Get.put(CheckoutController());
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          automaticallyImplyLeading: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          centerTitle: true,
          title: const Text(
            "Order Checkout",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Operator",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            GetBuilder<CheckoutController>(builder: (_) {
              return AbsorbPointer(
                  absorbing: true,
                  child: feild(
                      controller:
                          TextEditingController(text: checkoutController.mmid),
                      hintText: "OperatorId"));
            }),
            feild(controller: name, hintText: "Full Name"),
            Row(
              children: [
                Expanded(child: feild(controller: phone, hintText: "Phone")),
                Expanded(child: feild(controller: email, hintText: "Email"))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Order Summary:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            summaryitem(item: "SubTotal", value: "199.99"),
            summaryitem(item: "Express Shipping", value: "6.99"),
            summaryitem(item: "Taxes", value: "13.99"),
            summaryitem(
                item: "Discount", value: "39.99", color: Colors.green[700]),
            const Divider(),
            summaryitem(item: "Total", value: "180.98", size: 17),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "We will send the confirmation when your item(s) are on the way! Hope you enjoy your purchase"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Thank you!"),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: InkWell(
                  onTap: () {
                    if (name.text.isEmpty ||
                        phone.text.isEmpty ||
                        email.text.isEmpty) {
                      toast("Name/Phone/Email should not be empty.");
                      return;
                    }
                    Get.to(PaymentPage(
                      cartdata: cartdata,
                      name: name.text,
                      phone: phone.text,
                      email: email.text,
                    ));
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      // height: 30,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text(
                              "Pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    });
  }

  Widget summaryitem(
      {required String item,
      required String value,
      Color? color = Colors.black,
      double size = 15}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item),
          Text(
            "\$$value",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: color, fontSize: size),
          )
        ],
      ),
    );
  }
}
