import 'package:dibook/state/cart/providers/cart_provider.dart';
import 'package:dibook/state/cart/providers/cart_total_provider.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/order/confirm_address/screens/confirm_address_screen.dart';
import 'package:dibook/view/tabs/cart/components/cart_item.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: cart.when(
            data: (cart) {
              final cartTotal = ref.watch(cartTotalProvider(cart));
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Heading(text: "Cart"),
                    if (cart.items.isEmpty)
                      const Center(
                          child: Heading(text: "Cart is empty", sub: true)),
                    ...cart.items.map((e) => CartItemView(e)),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(height: 5),
                    ),
                    cartTotal.when(
                      data: (total) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading(text: "Total: Rs. $total"),
                          const SizedBox(height: 20),
                          MainButton(
                              text: "Proceed to Order",
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ConfirmAddressScreen(
                                        orders: cart.items
                                            .map((e) => OrderPayload(
                                                bookId: e.bookId,
                                                quantity: e.quantity,
                                                address: ""))
                                            .toList())));
                              }),
                        ],
                      ),
                      error: (e, _) => Text(e.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ]);
            },
            error: (e, _) => Text(e.toString()),
            loading: () => Column(
                children:
                    List.generate(4, (index) => ShimmerContainer(context)))),
      ),
    );
  }
}
