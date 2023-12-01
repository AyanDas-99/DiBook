// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItem {
  final String bookId;
  final int quantity;

  CartItem({required this.bookId, required this.quantity});

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      bookId: map['book_id'] as String,
      quantity: map['quantity'] as int,
    );
  }

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
