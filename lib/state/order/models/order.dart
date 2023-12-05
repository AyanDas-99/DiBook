class Order {
  final String orderId;
  final String bookId;
  final int quantity;
  final String address;
  final String status;

  Order(
      {required this.orderId,
      required this.bookId,
      required this.quantity,
      required this.address,
      required this.status});
}
