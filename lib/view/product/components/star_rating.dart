import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating(this.rating, {super.key});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          5,
          (index) => Icon(
                Icons.star,
                size: 20,
                color: (index < rating.floor()) ? Colors.orange : Colors.grey,
              )),
    );
  }
}
