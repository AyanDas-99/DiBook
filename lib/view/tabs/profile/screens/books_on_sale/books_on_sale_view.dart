import 'package:dibook/state/books/providers/books_on_sale_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/tabs/profile/screens/books_on_sale/book_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BooksOnSaleView extends ConsumerWidget {
  const BooksOnSaleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksOnSaleProvider);
    return Scaffold(
        appBar: customAppbar(context, leading: true, showSearchBar: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(text: "Books On Sale"),
                SingleChildScrollView(
                  child: books.when(
                      data: (books) => Column(
                            children: books.map((e) => BookCard(e)).toList(),
                          ),
                      error: (e, _) => Text(e.toString()),
                      loading: () => Column(
                          children: List.generate(
                              4, (index) => ShimmerContainer(context)))),
                ),
              ],
            ),
          ),
        ));
  }
}
