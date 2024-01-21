import 'package:dibook/state/sales/notifiers/sales_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final salesNotifierProvider =
    StateNotifierProvider<SalesNotifier, IsLoading>((ref) {
  return SalesNotifier(ref);
});
