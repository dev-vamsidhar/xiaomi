import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/checkout.controller.dart';
import 'package:frontend/model/cart.model.dart';
import 'package:frontend/model/ordermodel.dart';
import 'package:frontend/views/paymentstatus.view.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key,
      required this.cartdata,
      required this.name,
      required this.email,
      required this.phone})
      : super(key: key);
  final CartModel cartdata;
  final String name;
  final String email;
  final String phone;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool onlinemode = true;

  CheckoutController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Payment",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // constraints: BoxConstraints),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        summaryitem(item: "SubTotal", value: "199.99"),
                        summaryitem(item: "Express Shipping", value: "6.99"),
                        summaryitem(item: "Taxes", value: "13.99"),
                        summaryitem(
                            item: "Discount",
                            value: "39.99",
                            color: Colors.green[700]),
                        const Divider(),
                        summaryitem(item: "Total", value: "180.98", size: 17),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: onlinemode,
                            groupValue: true,
                            onChanged: (val) {
                              onlinemode = true;
                              setState(() {});
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: isSmallScreen ? 200 : 500,
                              child: const Text(
                                  "Online Payment mode(Debit/Credit/UPI/Net Banking")),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: onlinemode != false,
                            groupValue: false,
                            onChanged: (val) {
                              onlinemode = false;
                              setState(() {});
                            }),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Cash on delivery"),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                          "Recommended(Choose cash payment if you have low internet connection)"),
                    ),
                    sh20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: "Testing mode",
                                content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          "Please select the action you required"),
                                      sh20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(const PaymentStatus(
                                                paymentstatus: false,
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                child: Text(
                                                  "Fail",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          sw10,
                                          InkWell(
                                            onTap: () {
                                              controller.saveorder(
                                                  widget.cartdata,
                                                  widget.name,
                                                  widget.phone,
                                                  widget.email,
                                                  OrderModel(
                                                      subtotal: "199.99",
                                                      shipping: "6.99",
                                                      taxes: "13.99",
                                                      discount: "39.99",
                                                      total: "180.98"));
                                              Get.back();
                                              Get.to(const PaymentStatus(
                                                paymentstatus: true,
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.orange),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Sucess",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ]));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Proceed to payment",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sh20
                  ]),
            ),
          ),
        );
      }),
    );
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
