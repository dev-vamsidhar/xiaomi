import 'package:flutter/material.dart';
import 'package:frontend/helpers/widgets.helper.dart';
import 'package:get/get.dart';

class OrderCheckout extends StatelessWidget {
  const OrderCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isSmallScreen = MediaQuery.of(context).size.width < 600;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          automaticallyImplyLeading: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Operator",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            AbsorbPointer(
                absorbing: true,
                child: feild(
                    controller: TextEditingController(),
                    hintText: "OperatorId")),
            feild(controller: TextEditingController(), hintText: "Full Name"),
            Row(
              children: [
                Expanded(
                    child: feild(
                        controller: TextEditingController(),
                        hintText: "Phone")),
                Expanded(
                    child: feild(
                        controller: TextEditingController(), hintText: "Email"))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
            Divider(),
            summaryitem(item: "Total", value: "180.98", size: 17),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "We will send the confirmation when your item(s) are on the way! Hope you enjoy your purchase"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Thank you!"),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: InkWell(
                  onTap: () {},
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
