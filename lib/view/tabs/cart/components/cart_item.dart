import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/cart/models/cart_item.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemView extends ConsumerWidget {
  const CartItemView({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(cartItem.bookId));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: book.when(
          data: (book) => Row(
                children: [
                  Expanded(child: Text(book.name.shorten(10))),
                  Text(cartItem.quantity.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(cartItem.bookId)
                ],
              ),
          error: (e, _) => Text(e.toString()),
          loading: () => ShimmerContainer(context)),
    );
  }
}
