import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/views/home.view.dart';
import 'package:get/get.dart';

class StoreDetails extends StatefulWidget {
  StoreDetails({super.key});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  List storetypes = ["Mi Home", "Mi Store"];

  String storeType = "Mi Home";
  TextEditingController storename = TextEditingController();
  TextEditingController posId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(3, 4),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Colors.grey,
                    )
                  ]),
              child: Column(
                children: [
                  sh20,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Enter the details",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  sh20,
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: storename,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Enter the store name",
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          width: 1000,
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              hint: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Store Type"),
                              ),
                              underline: Container(),
                              iconSize: 0,
                              value: storeType,
                              items: storetypes
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e),
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                storeType = val.toString();
                                setState(() {});
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(Icons.keyboard_arrow_down_sharp),
                      )
                    ],
                  ),
                  sh10,
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: posId,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText:
                              "Enter the POS id(ID associated with machine type)",
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Get.offAll(HomePage());
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            height: 30,
                            width: 80,
                            child: const Center(
                                child: Text(
                              "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
