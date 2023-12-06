import 'package:dibook/state/cart/providers/cart_provider.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/state/order/providers/order_notifier_provider.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/tabs/cart/components/cart_item.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return SingleChildScrollView(
      child: cart.when(
          data: (cart) => Column(children: [
                ...cart.items.map((e) => CartItemView(cartItem: e)).toList(),
                MainButton(
                    text: "Buy",
                    onPressed: () {
                      ref.read(orderNotifierProvider.notifier).placeOrder(
                          context: context,
                          orderList: cart.items
                              .map((e) => OrderPayload(
                                  bookId: e.bookId,
                                  quantity: e.quantity,
                                  address: ""))
                              .toList());
                    })
              ]),
          error: (e, _) => Text(e.toString()),
          loading: () => Column(
              children:
                  List.generate(4, (index) => ShimmerContainer(context)))),
    );
  }
}
