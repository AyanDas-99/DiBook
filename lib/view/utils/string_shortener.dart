extension Shorten on String {
  String shorten(int size) {
    if (length > size) {
      return "${substring(0, size)}...";
    }
    return this;
  }
}
