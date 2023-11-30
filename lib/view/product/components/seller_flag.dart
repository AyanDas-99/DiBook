import 'package:flutter/material.dart';

Widget sellerFlag() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    margin: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.deepOrange),
    child: const Text(
      "Seller",
      style: TextStyle(color: Colors.white),
    ),
  );
}
