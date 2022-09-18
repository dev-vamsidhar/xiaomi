import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/controllers/cart.controller.dart';
import 'package:frontend/helpers/widgets.helper.dart';
import 'package:frontend/model/cart.model.dart';
import 'package:frontend/views/cart.view.dart';
import 'package:frontend/views/ordercheckout.view.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../helpers/logger.dart';

class ProductSelection extends StatefulWidget {
  ProductSelection({super.key, required this.sidebarcontroller});
  SidebarXController sidebarcontroller;

  @override
  State<ProductSelection> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<ProductSelection> {
  List<String> categories = [
    "Smart Phone",
    "TV's",
    "Laptop",
    "Smart Home Accessory"
  ];

  Map<String, List<String>> items = {
    "Smart Phone": [
      "Xiaomi redmi A1",
      "Xiaomi mix fold",
      "Poco x4 5g",
      "Redmi Note 7 Pro",
      "Redmi Note 11 Pro"
    ],
    "TV's": ["Redmi Smart Tv", "Redmi Android Tv", "Redmi LED Tv"],
    "Laptop": ["Mi notebook x45u", "Mi Gaming Laptop", "Redmi book"],
    "Smart Home Accessory": ['Smart LED', "Smart Swtich", "Remote control fans"]
  };
  CartController _cartController = Get.find();
  TextEditingController color = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController quantity = TextEditingController(text: "1");
  TextEditingController serainumber = TextEditingController();
  TextEditingController addressline1 = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController landmark = TextEditingController();
  String? category;
  String? item;
  bool homedelivery = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isSmallScreen = MediaQuery.of(context).size.width < 600;
      return Scaffold(
        appBar: isSmallScreen
            ? AppBar(
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
                  "Order Details",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                iconTheme: const IconThemeData(color: Colors.black),
              )
            : null,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Create an Order",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),

            // Dropdown to select the xiaomi category
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                width: 600,
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Select the category"),
                    ),
                    underline: Container(),
                    iconSize: 0,
                    value: category,
                    items: categories
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e),
                            )))
                        .toList(),
                    onChanged: (val) {
                      category = val.toString();
                      item = null;
                      setState(() {});
                    }),
              ),
            ),

            // Select item based on the selected product
            category != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                      width: 600,
                      child: DropdownButton(
                          dropdownColor: Colors.white,
                          hint: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Select the product"),
                          ),
                          underline: Container(),
                          iconSize: 0,
                          value: item,
                          items: items[category]!
                              .toList()
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  )))
                              .toList(),
                          onChanged: (val) {
                            item = val.toString();
                            setState(() {});
                          }),
                    ),
                  )
                : Container(),

            // Checkbox to get the delivery mode

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: homedelivery,
                    onChanged: (val) {
                      homedelivery = !homedelivery;
                      setState(() {});
                    },
                  ),
                  const Text("Home delivery")
                ],
              ),
            ),
            if (homedelivery)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Delivery Details",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ),
            if (homedelivery) ...[
              feild(controller: addressline1, hintText: "Address Line 1"),
              Row(
                children: [
                  Expanded(
                      // constraints: BoxConstraints(maxWidth: 400),
                      child: feild(controller: state, hintText: "State")),
                  Expanded(
                      // width: 300,
                      // constraints: BoxConstraints(maxWidth: 300, minWidth: 100),
                      child: feild(controller: country, hintText: "Country")),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        child:
                            feild(controller: landmark, hintText: "Landmark")),
                  ),
                  Expanded(
                    child: Container(
                        child: feild(controller: pincode, hintText: "Pincode")),
                  ),
                ],
              ),
            ],
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: feild(controller: color, hintText: "Color(eg. Red)"),
                ),
                Expanded(
                  child: feild(controller: size, hintText: "Size (in inches)"),
                )
              ],
            ),
            feild(controller: quantity, hintText: "Quantity(in number)"),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child:
                        feild(controller: serainumber, hintText: "S/N number")),
                Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.qr_code_scanner_rounded)))
              ],
            ),
            sh20,
            sh20,
            sh20,
            Align(
              alignment: Alignment.topRight,
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      if (item == null && category == null) {
                        toast("Select category and product.");
                        return;
                      }
                      if (color.text.isEmpty ||
                          quantity.text.isEmpty ||
                          serainumber.text.isEmpty) {
                        toast("All feilds are necessary to proceed.");
                        return;
                      }
                      CartModel cart = CartModel(
                          url: "",
                          title: "$item-$category",
                          color: color.text,
                          size: size.text,
                          price: "\$4923.00",
                          quantity: quantity.text,
                          homedelivery: homedelivery.toString(),
                          addressline1: addressline1.text,
                          state: state.text,
                          country: country.text,
                          landmark: landmark.text,
                          pincode: pincode.text);
                      // log(cart.tojson(cart));
                      await _cartController.addtoCart(cart);
                      if (isSmallScreen) {
                        Get.to(Cart());
                        return;
                      }
                      widget.sidebarcontroller.selectIndex(2);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          // height: 30,
                          width: 130,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Center(
                                    child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                                Icon(
                                  FontAwesomeIcons.bagShopping,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        if (item == null && category == null) {
                          toast("Select category and product.");
                          return;
                        }
                        if (color.text.isEmpty ||
                            quantity.text.isEmpty ||
                            serainumber.text.isEmpty) {
                          toast("All feilds are necessary to proceed.");
                          return;
                        }

                        CartModel cart = CartModel(
                            url: "",
                            title: "$item-$category",
                            color: color.text,
                            size: size.text,
                            price: "\$4923.00",
                            quantity: quantity.text,
                            homedelivery: homedelivery.toString(),
                            addressline1: addressline1.text,
                            state: state.text,
                            country: country.text,
                            landmark: landmark.text,
                            pincode: pincode.text);
                        // _cartController.deleteall();
                        Get.to(OrderCheckout(
                          cartdata: cart,
                        ));
                        return;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Center(
                                    child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
