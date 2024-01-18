import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/cart/providers/update_cart_notifier_provider.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/order/confirm_address/screens/confirm_address_screen.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuyAndCartButtons extends ConsumerWidget {
  const BuyAndCartButtons(this.bookId, {super.key});
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(bookId));
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            book.when(
                data: (book) => (book.stock == 0)
                    ? const Text("Not available")
                    : TextButton(
                        onPressed: (book.stock == 0)
                            ? null
                            : () {
                                // ref
                                //     .read(orderNotifierProvider.notifier)
                                //     .placeOrder(context: context, orderList: [
                                //   OrderPayload(
                                //       bookId: bookId, quantity: 1, address: "")
                                // ]);

                                ref.invalidate(bookByIdProvider);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ConfirmAddressScreen(
                                          orders: [
                                            OrderPayload(
                                                bookId: bookId,
                                                quantity: 1,
                                                address: "")
                                          ],
                                        )));
                              },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              ThemeConstants.mainYellow),
                          shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                error: (e, _) => Text(e.toString()),
                loading: () => const CircularProgressIndicator()),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {
                ref
                    .read(updateCartNotifierProvider.notifier)
                    .addToCart(context: context, bookId: bookId);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ThemeConstants.lightGreen),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
              ),
              child: const Text(
                "Add To Cart",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
