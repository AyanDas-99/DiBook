import 'package:dibook/state/order/providers/all_orders_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/tabs/profile/screens/orders/components/order_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderView extends ConsumerWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(allOrdersProvider);
    return Scaffold(
        appBar: customAppbar(context, leading: true, showSearchBar: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(text: "Orders"),
                orders.when(
                    data: (orders) => Column(
                          children:
                              orders.map((e) => OrderCard(order: e)).toList(),
                        ),
                    error: (e, _) => Text(e.toString()),
                    loading: () => Column(
                        children: List.generate(
                            4, (index) => ShimmerContainer(context)))),
              ],
            ),
          ),
        ));
  }
}
