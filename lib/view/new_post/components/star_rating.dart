import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRating extends StatelessWidget {
  final void Function(double value) onUpdate;
  const StarRating({super.key, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (BuildContext context, int index) {
        return const Icon(
          Icons.star,
          color: Colors.orange,
        );
      },
      onRatingUpdate: onUpdate,
    );
  }
}
