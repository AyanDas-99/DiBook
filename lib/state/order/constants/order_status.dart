enum OrderStatus {
  notDispatched,
  dispatched,
  reached,
  delivered,
}

extension StatusParse on OrderStatus {
  String string() {
    if (name == OrderStatus.notDispatched.name) {
      return "Not Dispatched";
    } else if (name == OrderStatus.dispatched.name) {
      return "Dispatched";
    } else if (name == OrderStatus.reached.name) {
      return "Reached Station";
    }
    return "Delivered";
  }
}
