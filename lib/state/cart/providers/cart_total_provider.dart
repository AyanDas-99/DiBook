import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/cart/models/cart.dart';
import 'package:dibook/state/cart/models/cart_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartTotalProvider =
    FutureProvider.family.autoDispose<int, Cart>((ref, Cart cart) async {
  int total = 0;
  for (CartItem item in cart.items) {
    final book = ref.watch(bookByIdProvider(item.bookId));
    book.whenData((value) {
      total += value.price * item.quantity;
    });
  }
  return total;
});
