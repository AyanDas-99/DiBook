import 'package:dibook/state/books/notifiers/update_book.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateBookProvider =
    StateNotifierProvider<UpdateBookNotifier, IsLoading>((ref) {
  return UpdateBookNotifier(ref);
});
