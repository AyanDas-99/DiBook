import 'package:flutter/material.dart';

class DiscountPercent extends StatelessWidget {
  const DiscountPercent({super.key, required this.mrp, required this.price});
  final int mrp;
  final int price;
  int discount(int mrp, int price) => 100 - ((price / mrp) * 100).ceil();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.red),
      child: Text(
        "${discount(mrp, price)}% off",
        style: const TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w200),
      ),
    );
  }
}
