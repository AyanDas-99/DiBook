// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderPayload {
  final String bookId;
  int quantity;
  String address;

  OrderPayload({
    required this.bookId,
    required this.quantity,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookId': bookId,
      'quantity': quantity,
      'address': address,
    };
  }

  OrderPayload copyWithAddress(String address) {
    this.address = address;
    return this;
  }

  set setQuantity(int val) => quantity = val;

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return "${bookId} : ${quantity} : ${address}";
  }
}
