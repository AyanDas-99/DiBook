// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dibook/state/sales/strings/sale_key.dart';
import 'package:equatable/equatable.dart';

class Sale extends Equatable {
  final String id;
  final String orderId;
  final String sellerId;
  final String bookId;
  final String bookName;
  final int soldCount;
  final int price;
  final DateTime soldOn;

  const Sale({
    required this.id,
    required this.orderId,
    required this.sellerId,
    required this.bookId,
    required this.bookName,
    required this.soldCount,
    required this.price,
    required this.soldOn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SaleKey.saleId: id,
      SaleKey.orderId: orderId,
      SaleKey.sellerId: sellerId,
      SaleKey.bookId: bookId,
      SaleKey.bookName: bookName,
      SaleKey.soldCount: soldCount,
      SaleKey.price: price,
      SaleKey.soldOn: soldOn.millisecondsSinceEpoch,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map[SaleKey.saleId] as String,
      orderId: map[SaleKey.orderId] as String,
      sellerId: map[SaleKey.sellerId] as String,
      bookId: map[SaleKey.bookId] as String,
      bookName: map[SaleKey.bookName] as String,
      soldCount: map[SaleKey.soldCount] as int,
      price: map[SaleKey.price] as int,
      soldOn: DateTime.parse(map[SaleKey.soldOn]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sale.fromJson(String source) =>
      Sale.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [id, orderId, sellerId, bookId, bookName, soldCount, price, soldOn];
}
