// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/cart/models/cart_item.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
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

  factory Cart.fromOrderPayloadList(String userId, List<OrderPayload> orders) {
    Cart cart = Cart(userId: userId, items: []);
    for (OrderPayload order in orders) {
      cart.items.add(CartItem(bookId: order.bookId, quantity: order.quantity));
    }
    return cart;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, items];
}
