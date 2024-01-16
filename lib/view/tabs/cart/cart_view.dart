import 'package:dibook/state/cart/providers/cart_provider.dart';
import 'package:dibook/state/cart/providers/cart_total_provider.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/auth/screens/auth_screen_view.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/order/confirm_address/screens/confirm_address_screen.dart';
import 'package:dibook/view/tabs/cart/components/cart_item.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/tabs/profile/constants.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final user = ref.watch(userProvider);
    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Cannot access cart"),
            const SizedBox(height: 20),
            InkWell(
                child: Heading(
                  text: Constants.logIn,
                  sub: true,
                  color: Colors.indigoAccent,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthScreenView(),
                      ));
                }),
          ],
        ),
      );
    }
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
                      error: (e, _) => InkWell(
                        onTap: () {
                          ref.invalidate(cartProvider);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.rotateLeft,
                                color: ThemeConstants.darkGreen,
                              ),
                              const Heading(text: "Something went wrong")
                            ],
                          ),
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ]);
            },
            error: (e, _) => InkWell(
                  onTap: () {
                    ref.invalidate(cartProvider);
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.rotateLeft,
                          color: ThemeConstants.darkGreen,
                        ),
                        const Heading(text: "Something went wrong")
                      ],
                    ),
                  ),
                ),
            loading: () => Column(
                children:
                    List.generate(4, (index) => ShimmerContainer(context)))),
      ),
    );
  }
}
