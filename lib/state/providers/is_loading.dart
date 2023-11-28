import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/book_upload/providers/book_upload_notifier_provider.dart';
import 'package:dibook/state/message/providers/upload_message_notifier_provider.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<IsLoading>((ref) {
  final IsLoading authLoading = ref.watch(authStateProvider);
  final IsLoading bookUploadLoading = ref.watch(bookUploadNotifierProvider);
  final IsLoading messageUploadLoading =
      ref.watch(uploadMessageNotifierProvider);
  return authLoading || bookUploadLoading || messageUploadLoading;
});
