import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key, required this.mrp, required this.price});
  final int mrp;
  final int price;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(
              text: "Rs. $price",
              color: ThemeConstants.darkGreen,
            ),
            Text(
              "MRP. Rs. $mrp",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
      ),
    );
  }
}
