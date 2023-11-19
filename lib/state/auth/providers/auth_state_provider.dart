import 'package:dibook/state/auth/notifiers/auth_state_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, IsLoading>((Ref ref) {
  return AuthStateNotifier(ref);
});
