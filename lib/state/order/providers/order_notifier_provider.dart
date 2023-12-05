import 'package:dibook/state/order/notifiers/order_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orderNotifierProvider =
    StateNotifierProvider<OrderNotifier, IsLoading>((ref) {
  return OrderNotifier(ref);
});
