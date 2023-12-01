import 'package:dibook/state/cart/providers/cart_provider.dart';
import 'package:dibook/view/cart/components/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return cart.when(
        data: (cart) => ListView.builder(
              itemBuilder: (context, index) =>
                  CartItemView(cartItem: cart.items[index]),
              itemCount: cart.items.length,
            ),
        error: (e, _) => Text(e.toString()),
        loading: () => CircularProgressIndicator());
  }
}
