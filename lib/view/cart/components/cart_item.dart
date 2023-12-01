import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemView extends ConsumerWidget {
  const CartItemView({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(cartItem.bookId));
    return book.when(
        data: (book) => Row(
              children: [
                Expanded(child: Text(book.name)),
                Text(cartItem.quantity.toString())
              ],
            ),
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
