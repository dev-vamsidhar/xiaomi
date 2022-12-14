import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/cart.controller.dart';
import 'package:frontend/views/ordercheckout.view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sidebarx/sidebarx.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    _cartController.getCartItems();
    return SafeArea(
      child: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 800;
        return Scaffold(
            backgroundColor: isSmallScreen ? Colors.white : null,
            appBar: isSmallScreen
                ? AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: Text("Cart"),
                  )
                : null,
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
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Image.network(
                                                _.cartitems[index].title
                                                        .toString()
                                                        .contains("Smart Phone")
                                                    ? "https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/91kAtEXPIeL._AC_UY218_.jpg"
                                                    : _.cartitems[index].title
                                                            .toString()
                                                            .contains("TV")
                                                        ? "https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71g3OF4CL9L._AC_SR180,120_QL70_.jpg"
                                                        : "https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71f6IcLBM6L._AC_UY218_.jpg",
                                                height: isSmallScreen
                                                    ? Get.width / 5
                                                    : Get.width / 10,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 8),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(OrderCheckout(
                                                          cartdata: _
                                                              .cartitems[index],
                                                        ));
                                                      },
                                                      child: Container(
                                                        width: isSmallScreen
                                                            ? Get.width / 2
                                                            : null,
                                                        child: Text(
                                                            _.cartitems[index]
                                                                .title,
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17)),
                                                      ),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 15,
                                                            width: 2,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              _.deleteCartItem(_
                                                                  .cartitems[
                                                                      index]
                                                                  .id);
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          74,
                                                                          174,
                                                                          255),
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline),
                                                            )),
                                                      ],
                                                    ),
                                                    isSmallScreen
                                                        ? Text(
                                                            "\$1980.00",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : Container()
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        !isSmallScreen
                                            ? Text("\$1980.00")
                                            : Container()
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
            ));
      }),
    );
  }
}
