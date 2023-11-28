import 'package:dibook/state/books/providers/category_books_provider.dart';
import 'package:dibook/view/components/books_list.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryBooksView extends ConsumerWidget {
  const CategoryBooksView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(categoryBooksProvider(category));
    return Scaffold(
      appBar: customAppbar(context, leading: true),
      body: books.when(
          data: (books) => BooksList(title: category, books: books),
          error: (e, _) => Text(e.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
