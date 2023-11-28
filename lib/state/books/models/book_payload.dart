import 'dart:convert';
import 'dart:io';
import 'package:dibook/state/books/strings/book_keys.dart';

class BookPayload {
  final String name;
  final String description;
  final String category;
  final double mrp;
  final int stock;
  final int missingPages;
  final double frontRating;
  final double backRating;
  final double markingsRating;
  final double bindingRating;
  final double overallRating;
  final List<File> images;

  late final double rating;
  late final int price;
  final List<String> imageLinks = [];

  BookPayload({
    required this.name,
    required this.description,
    required this.category,
    required this.mrp,
    required this.stock,
    required this.missingPages,
    required this.frontRating,
    required this.backRating,
    required this.markingsRating,
    required this.bindingRating,
    required this.overallRating,
    required this.images,
  }) {
    double missingPageRating;
    if (missingPages == 0) {
      missingPageRating = 5;
    } else if (missingPages < 3) {
      missingPageRating = 4;
    } else if (missingPages < 6) {
      missingPageRating = 3;
    } else if (missingPages < 11) {
      missingPageRating = 2;
    } else {
      missingPageRating = 1;
    }

    rating = (missingPageRating +
            frontRating +
            backRating +
            markingsRating +
            bindingRating +
            overallRating) /
        6;

    price = _calculatePrice(rating);
  }

  BookPayload copyWithImageLinks(List<String> links) {
    imageLinks.addAll(links);
    return this;
  }

  int _calculatePrice(double rating) {
    double price = mrp;
    price -= price * 0.3;
    price *= rating / 5;
    return price.round();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      BookKeys.name: name,
      BookKeys.description: description,
      BookKeys.category: category,
      BookKeys.mrp: mrp,
      BookKeys.stock: stock,
      BookKeys.rating: rating,
      BookKeys.price: price,
      BookKeys.images: imageLinks,
      BookKeys.frontRating: frontRating,
      BookKeys.backRating: backRating,
      BookKeys.markingsRating: markingsRating,
      BookKeys.bindingRating: bindingRating,
    };
  }

  String toJson() => json.encode(toMap());
}
