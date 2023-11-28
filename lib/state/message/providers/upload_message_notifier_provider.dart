import 'package:dibook/state/message/notifiers/upload_message_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadMessageNotifierProvider =
    StateNotifierProvider<UploadMessageNotifier, IsLoading>((ref) {
  return UploadMessageNotifier(ref);
});
