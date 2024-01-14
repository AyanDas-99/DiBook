import 'dart:math';

import 'package:dibook/state/books/providers/category_books_provider.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/tabs/home/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryProductList extends ConsumerWidget {
  const CategoryProductList({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(categoryBooksProvider(category));
    return books.when(
        data: (booksList) {
          booksList = booksList.sublist(0, min(booksList.length, 5));
          if (booksList.isEmpty) {
            return Container();
          }
          final productCards =
              booksList.map((e) => ProductCard(book: e)).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(text: category, sub: true),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productCards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: productCards[index],
                        )),
              ),
            ],
          );
        },
        error: (e, _) => Text(e.toString()),
        loading: () => SizedBox(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("asset/gif/shimmer.gif"),
                      )),
            ));
  }
}
