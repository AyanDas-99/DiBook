import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/notifier/update_user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateUserNotifierProvider =
    StateNotifierProvider<UpdateUserNotifier, IsLoading>((ref) {
  return UpdateUserNotifier(ref);
});
