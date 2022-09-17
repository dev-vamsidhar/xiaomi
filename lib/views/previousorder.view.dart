import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/orders.controller.dart';
import 'package:get/get.dart';

class PreviousOrder extends StatefulWidget {
  const PreviousOrder({Key? key}) : super(key: key);

  @override
  State<PreviousOrder> createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 800;
        return GetBuilder<OrderController>(builder: (_) {
          return _.pastorder.length > 0
              ? ListView.separated(
                  itemCount: _.pastorder.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                child: Image.network(
                                  _.pastorder[index]['title']
                                          .toString()
                                          .contains("Smart Phone")
                                      ? "https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/91kAtEXPIeL._AC_UY218_.jpg"
                                      : _.pastorder[index]['title']
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2,
                                        child: InkWell(
                                          onTap: () {
                                            // Get.to(OrderCheckout(
                                            //   cartdata:
                                            //       _.cartitems[index],
                                            // ));
                                          },
                                          child: Text(
                                              _.pastorder[index]['title'],
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        ),
                                      ),
                                      sh5,
                                      Text(
                                          "Color: ${_.pastorder[index]['color']}"),
                                      sh5,
                                      Text(
                                          "Size: ${_.pastorder[index]['size']}"),
                                      sh5,
                                      Row(
                                        children: [
                                          Text(
                                              "Qnty: ${_.pastorder[index]['quantity']}"),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 15,
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      isSmallScreen
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("\$1980.00"),
                                                sh10,
                                                const Text(
                                                  "Status: Completed",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ],
                                            )
                                          : Container()
                                    ]),
                              ),
                              !isSmallScreen
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("\$1980.00"),
                                        sh10,
                                        const Text(
                                          "Status: Completed",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No Orders done"),
                    sh10,
                    InkWell(
                      onTap: () {
                        _.getEmployeeOrderFromDb();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Refresh",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                );
        });
      }),
    );
  }
}
