import 'package:dibook/state/book_upload/notifiers/book_upload_notifier.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bookUploadNotifierProvider =
    StateNotifierProvider<BookUploadNotifier, IsLoading>((ref) {
  return BookUploadNotifier(ref);
});
