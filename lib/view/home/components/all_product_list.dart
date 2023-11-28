import 'package:dibook/state/books/providers/all_books_provider.dart';
import 'package:dibook/view/home/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(allBooksProvider);
    return books.when(
        data: (booksList) {
          final productCards =
              booksList.map((e) => ProductCard(book: e)).toList();
          return SizedBox(
            height: 200,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: productCards.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: productCards[index],
                    )),
          );
        },
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
