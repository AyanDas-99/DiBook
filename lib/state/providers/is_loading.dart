import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<IsLoading>((ref) {
  final IsLoading authLoading = ref.watch(authStateProvider);
  return authLoading;
});