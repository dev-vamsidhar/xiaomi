
  import 'package:flutter/material.dart';

Widget feild(
      {required TextEditingController controller, required String hintText}) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Colors.black,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
        ),
      ),
    );
  }