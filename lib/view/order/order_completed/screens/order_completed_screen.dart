import 'dart:io';
import 'dart:typed_data';
import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/order/providers/order_receipt_provider.dart';
import 'package:dibook/state/utils/save_file_to_documents.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/main_view.dart';
import 'package:dibook/view/order/order_completed/components/animated_tick.dart';
import 'package:dibook/view/order/order_completed/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OrderCompletedScreen extends StatefulHookConsumerWidget {
  const OrderCompletedScreen(
      {required this.orders, required this.paymentMethod, super.key});
  final List<Order> orders;
  final String paymentMethod;

  @override
  ConsumerState<OrderCompletedScreen> createState() =>
      _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends ConsumerState<OrderCompletedScreen> {
  Uint8List? orderReceipt;
  bool? receiptLoaded;
  void getReceipt() async {
    receiptLoaded = null;
    orderReceipt = await ref.watch(orderReceiptProvider.notifier).buildReceipt(
        orderIds: widget.orders.map((e) => e.orderId).toList(),
        paymentMethod: widget.paymentMethod,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    getReceipt();

    useEffect(() {
      if (orderReceipt == null) {
        receiptLoaded = false;
      } else {
        receiptLoaded = true;
      }
      setState(() {});
      return null;
    }, [orderReceipt]);

    return Scaffold(
      appBar: customAppbar(context,
          showSearchBar: false,
          leading: true,
          leadingWidget: InkWell(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainView()),
                (route) => false),
            child: const Icon(Icons.arrow_back_rounded),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedPrompt(
                  title: Strings.yourOrderHasBeenConfirmed,
                  subtitle: '',
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(receiptLoaded.toString()),
            // Order Receipt
            RoundedContainer(
              width: 50,
              child: (receiptLoaded != null)
                  ? (receiptLoaded == true)
                      ? InkWell(
                          onTap: () => saveToDocuments(
                              orderReceipt!, "Receipt", context),
                          child: const FaIcon(FontAwesomeIcons.solidFilePdf))
                      : const FaIcon(FontAwesomeIcons.circleArrowUp)
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
