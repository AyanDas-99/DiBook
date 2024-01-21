import 'dart:convert';
import 'package:dibook/state/order/constants/order_keys.dart';
import 'package:dibook/state/order/constants/order_status.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String userId;
  final String orderId;
  final String bookId;
  final int quantity;
  final String address;
  final OrderStatus status;
  final DateTime createdAt;

  const Order(
      {required this.userId,
      required this.orderId,
      required this.bookId,
      required this.quantity,
      required this.address,
      required this.status,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OrderKeys.userId: userId,
      OrderKeys.orderId: orderId,
      OrderKeys.bookId: bookId,
      OrderKeys.quantity: quantity,
      OrderKeys.address: address,
      OrderKeys.status: status.name,
      OrderKeys.createdAt: createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        userId: map[OrderKeys.userId] as String,
        orderId: map[OrderKeys.orderId] as String,
        bookId: map[OrderKeys.bookId] as String,
        quantity: map[OrderKeys.quantity] as int,
        address: map[OrderKeys.address] as String,
        status: OrderStatus.values
            .firstWhere((element) => element.name == map[OrderKeys.status]),
        createdAt: DateTime.parse(map[OrderKeys.createdAt]));
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [userId, orderId, bookId, quantity, address, status];
}
