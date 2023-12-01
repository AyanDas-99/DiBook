import 'package:dibook/state/cart/notifiers/update_cart_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateCartNotifierProvider =
    StateNotifierProvider<UpdateCartNotifier, IsLoading>((ref) {
  return UpdateCartNotifier(ref);
});
