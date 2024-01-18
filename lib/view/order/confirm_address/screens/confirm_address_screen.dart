import 'dart:async';
import 'dart:math';
import 'package:dibook/state/books/providers/books_by_id_list_provider.dart';
import 'package:dibook/state/models/list_wrapper.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/order/payment/screens/payment_screen.dart';
import 'package:dibook/view/order/confirm_address/screens/address_select.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmAddressScreen extends ConsumerStatefulWidget {
  const ConfirmAddressScreen({required this.orders, super.key});
  final List<OrderPayload> orders;

  @override
  ConsumerState<ConfirmAddressScreen> createState() =>
      _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends ConsumerState<ConfirmAddressScreen> {
  final customAddressController = TextEditingController();

  int counter = 10;
  Timer? _timer;

  void goBackIn10Secs(BuildContext context) {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        Navigator.pop(context);
      } else {
        setState(() {
          counter--;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListWrapper ids = ListWrapper(widget.orders.map((e) => e.bookId).toList());
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
                widget.orders
                    .removeWhere((order) => order.bookId == element.bookId);
                return true;
              }
              return false;
            },
          );

          if (data.isEmpty) {
            goBackIn10Secs(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Heading(
                    text: "None of the books in your cart are available",
                    sub: true,
                  ),
                  const SizedBox(height: 30),
                  MainButton(
                    text: "Going back in $counter s",
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            );
          }

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
                                widget.orders[e.key].setQuantity = min(
                                    widget.orders[e.key].quantity,
                                    e.value.stock);
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
                                      "${widget.orders[e.key].quantity}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${e.value.price * widget.orders[e.key].quantity}",
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
                    text: "Proceed",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                              orders: widget.orders,
                              customAddress: customAddressController.text)));
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
