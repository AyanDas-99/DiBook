import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/models/list_wrapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final booksByIdListProvider = FutureProvider.family
    .autoDispose<List<Book>, ListWrapper>((ref, ids) async {
  List<Book> books = [];

  for (String id in ids.items) {
    final book = ref.watch(bookByIdProvider(id));
    book.whenData((value) {
      books.add(value);
    });
  }

  return books;
});
