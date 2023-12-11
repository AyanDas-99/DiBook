import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/notifier/update_photo_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updatePhotoProvider =
    StateNotifierProvider<UpdatePhotoNotifier, IsLoading>((ref) {
  return UpdatePhotoNotifier(ref);
});
