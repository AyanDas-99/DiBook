import 'package:dibook/state/books/providers/searched_books_provider.dart';
import 'package:dibook/view/components/books_list.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchedBooksView extends ConsumerWidget {
  const SearchedBooksView({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(searchedBooksProvider(searchQuery));
    return Scaffold(
      appBar: customAppbar(context, leading: true),
      body: books.when(
          data: (books) => BooksList(title: searchQuery, books: books),
          error: (e, _) => Text(e.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
