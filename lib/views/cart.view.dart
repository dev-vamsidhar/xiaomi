import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/cart.controller.dart';
import 'package:frontend/views/ordercheckout.view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  CartController _cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cart Items",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            GetBuilder<CartController>(builder: (_) {
              return _.cartitems.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  offset: Offset(3, 2))
                            ]),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _.cartitems.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        "https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71k86pEH5LS._AC_AA180_.jpg",
                                        height: 130,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(OrderCheckout());
                                                },
                                                child: Text(
                                                    _.cartitems[index].title,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17)),
                                              ),
                                              sh5,
                                              Text(
                                                  "Color: ${_.cartitems[index].color}"),
                                              sh5,
                                              Text(
                                                  "Size: ${_.cartitems[index].size}"),
                                              sh5,
                                              Row(
                                                children: [
                                                  Text(
                                                      "Qnty: ${_.cartitems[index].quantity}"),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 15,
                                                      width: 2,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        _.deleteCartItem(_
                                                            .cartitems[index]
                                                            .id);
                                                      },
                                                      child:const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    74,
                                                                    174,
                                                                    255),
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                      )),
                                                ],
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                  Text("\$1980.00")
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Get.height / 1.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lotties/emptycart.json",
                                height: 200),
                            Center(
                              child: Container(
                                child: Text("Cart is empty"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
