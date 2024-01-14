import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/order/providers/order_receipt_provider.dart';
import 'package:dibook/state/utils/download_file.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/text_and_icon.dart';
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
  String? orderReceipt;
  late Future<String?> orderReceiptFuture;

  void getReceipt() {
    orderReceiptFuture = ref.read(orderReceiptProvider.notifier).buildReceipt(
        orderIds: widget.orders.map((e) => e.orderId).toList(),
        paymentMethod: widget.paymentMethod,
        context: context);
  }

  @override
  void initState() {
    getReceipt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      print("useEffect updated..");
      orderReceiptFuture.then((value) {
        setState(() {
          orderReceipt = value;
        });
      });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedPrompt(
                  title: Strings.yourOrderHasBeenConfirmed,
                  subtitle: '',
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Order Receipt
            InkWell(
              onTap: () {
                if (orderReceipt != null) {
                  if (orderReceipt!.isEmpty) {
                    getReceipt();
                  } else {
                    // Download file
                    downloadFile(orderReceipt!);
                  }
                }
              },
              child: RoundedContainer(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: (orderReceipt != null)
                      ? (orderReceipt!.isNotEmpty)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Download Receipt",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Image.asset(
                                  'asset/images/pdf.png',
                                  width: 40,
                                ),
                              ],
                            )
                          : const TextAndIcon(
                              text: "Receipt Failed",
                              icon: FontAwesomeIcons.rotateRight)
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
