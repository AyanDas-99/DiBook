import 'dart:math';
import 'package:dibook/state/books/providers/books_by_id_list_provider.dart';
import 'package:dibook/state/models/list_wrapper.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/order/screens/confirm_address/address_select.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmAddressScreen extends ConsumerWidget {
  ConfirmAddressScreen({required this.orders, super.key});
  final List<OrderPayload> orders;

  final customAddressController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ListWrapper ids = ListWrapper(orders.map((e) => e.bookId).toList());
    final books = ref.watch(booksByIdListProvider(ids));
    return Scaffold(
      appBar: customAppbar(context, showSearchBar: false, leading: true),
      body: books.when(
        data: (data) {
          //
          // Removing books where stock is 0
          data.removeWhere(
            (element) {
              if (element.stock == 0) {
                orders.removeWhere((order) => order.bookId == element.bookId);
                return true;
              }
              return false;
            },
          );

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  RoundedContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(
                            text: "You are buying these",
                            sub: true,
                          ),
                          const SizedBox(height: 20),
                          Table(
                            border: TableBorder.all(color: Colors.black),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(2.5)
                            },
                            children: [
                              const TableRow(
                                children: [
                                  Text(
                                    "Books",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Price",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Quantity",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Cost",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              ...data.asMap().entries.map((e) {
                                orders[e.key].setQuantity =
                                    min(orders[e.key].quantity, e.value.stock);
                                return TableRow(
                                  children: [
                                    Text(
                                      e.value.name.shorten(20),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${e.value.price}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${orders[e.key].quantity}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${e.value.price * orders[e.key].quantity}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                          const SizedBox(height: 40),
                          const Heading(
                              text: "Confirm your delivery address", sub: true),
                          const SizedBox(height: 20),
                          AddressSelect(controller: customAddressController),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  MainButton(
                    text: "Press",
                    onPressed: () {
                      print(customAddressController.text);
                    },
                  )
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
