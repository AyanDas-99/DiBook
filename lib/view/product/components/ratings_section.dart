import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/components/star_rating.dart';
import 'package:flutter/material.dart';

class RatingsSection extends StatelessWidget {
  const RatingsSection(this.book, {super.key});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Heading(text: "Individual Quality-based Rating", sub: true),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 150, child: Text("Front Cover")),
                StarRating(book.frontRating),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 150, child: Text("Back Cover")),
                StarRating(book.backRating),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 150, child: Text("Markings")),
                StarRating(book.markingsRating),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 150, child: Text("Binding")),
                StarRating(book.bindingRating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
