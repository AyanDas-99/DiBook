import 'package:dibook/state/cart/models/cart.dart';
import 'package:dibook/state/cart/providers/cart_total_provider.dart';
import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/state/order/providers/order_notifier_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/order/order_completed/screens/order_completed_screen.dart';
import 'package:dibook/view/order/payment/payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    required this.orders,
    required this.customAddress,
    super.key,
  });
  final List<OrderPayload> orders;
  final String customAddress;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  PaymentMethod paymentMethod = PaymentMethod.card;

  @override
  Widget build(BuildContext context) {
    final total = ref
        .watch(cartTotalProvider(Cart.fromOrderPayloadList("", widget.orders)));
    return Scaffold(
      appBar: customAppbar(context, showSearchBar: false, leading: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: total.when(
          data: (data) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Radio<PaymentMethod>(
                              value: PaymentMethod.card,
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = value!;
                                });
                              }),
                          title: Text("Card - Rs.$data"),
                        ),
                        ListTile(
                          leading: Radio<PaymentMethod>(
                              value: PaymentMethod.payOnDelivery,
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = value!;
                                });
                              }),
                          title: const Text("Pay on Delivery"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MainButton(
                  text: "Place Order",
                  onPressed: () async {
                    // Directly place order if method is pay on delivery
                    if (paymentMethod == PaymentMethod.payOnDelivery) {
                      List<Order> orders = await ref
                          .read(orderNotifierProvider.notifier)
                          .placeOrder(
                              context: context,
                              orderList: widget.orders
                                  .map((e) =>
                                      e.copyWithAddress(widget.customAddress))
                                  .toList());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderCompletedScreen(
                              orders: orders,
                              paymentMethod: paymentMethod.name)));
                    }
                  },
                ),
                ...widget.orders.map((e) => Text("${e.bookId} : ${e.quantity}"))
              ],
            ),
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
