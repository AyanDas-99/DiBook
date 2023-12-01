// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/cart/models/cart_item.dart';

class Cart {
  final String userId;
  final List<CartItem> items;

  Cart({required this.userId, required this.items});

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      userId: map['user_id'] as String,
      items: List<CartItem>.from(
        (map['items'] as List).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
