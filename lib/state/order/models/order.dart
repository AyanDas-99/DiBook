import 'dart:convert';
import 'package:dibook/state/order/constants/order_keys.dart';

class Order {
  final String userId;
  final String orderId;
  final String bookId;
  final int quantity;
  final String address;
  final String status;

  Order(
      {required this.userId,
      required this.orderId,
      required this.bookId,
      required this.quantity,
      required this.address,
      required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OrderKeys.userId: userId,
      OrderKeys.orderId: orderId,
      OrderKeys.bookId: bookId,
      OrderKeys.quantity: quantity,
      OrderKeys.address: address,
      OrderKeys.status: status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userId: map[OrderKeys.userId] as String,
      orderId: map[OrderKeys.orderId] as String,
      bookId: map[OrderKeys.bookId] as String,
      quantity: map[OrderKeys.quantity] as int,
      address: map[OrderKeys.address] as String,
      status: map[OrderKeys.status] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  operator ==(covariant Order other) =>
      userId == other.userId &&
      orderId == other.orderId &&
      bookId == other.bookId &&
      quantity == other.quantity &&
      status == other.status;

  @override
  int get hashCode =>
      Object.hashAll([userId, orderId, bookId, quantity, address, status]);
}
