import 'package:dibook/state/order/notifiers/order_receipt_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orderReceiptProvider =
    StateNotifierProvider<OrderReceiptNotifier, Null>((ref) {
  return OrderReceiptNotifier(ref);
});
