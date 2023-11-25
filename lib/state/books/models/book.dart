// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/books/strings/book_keys.dart';

class Book {
  final String bookId;
  final String name;
  final String description;
  final String category;
  final int mrp;
  final int stock;
  final List<String> images;
  final double rating;
  final int price;

  Book(this.bookId,
      {required this.name,
      required this.description,
      required this.category,
      required this.mrp,
      required this.stock,
      required this.images,
      required this.rating,
      required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      BookKeys.name: name,
      BookKeys.description: description,
      BookKeys.category: category,
      BookKeys.mrp: mrp,
      BookKeys.stock: stock,
      BookKeys.images: images,
      BookKeys.rating: rating,
      BookKeys.price: price,
      BookKeys.bookId: bookId,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      map[BookKeys.bookId],
      name: map[BookKeys.name] as String,
      description: map[BookKeys.description] as String,
      category: map[BookKeys.category] as String,
      mrp: map[BookKeys.mrp] as int,
      stock: map[BookKeys.stock] as int,
      images: (map[BookKeys.images] as List).map((e) => e.toString()).toList(),
      rating: double.parse(map[BookKeys.rating].toString()),
      price: map[BookKeys.price] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  operator ==(covariant Book other) =>
      bookId == other.bookId && name == other.name;

  @override
  int get hashCode => Object.hashAll([bookId]);
}
