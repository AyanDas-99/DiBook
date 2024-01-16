import 'dart:math';

import 'package:dibook/state/books/providers/all_books_provider.dart';
import 'package:dibook/view/tabs/home/components/product_card.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllProductList extends ConsumerWidget {
  const AllProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(allBooksProvider);
    return books.when(
        data: (booksList) {
          booksList = booksList.sublist(0, min(booksList.length, 5));

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
        error: (e, _) => Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.circleExclamation,
                  color: ThemeConstants.darkGreen,
                ),
                const Text("Something went wrong"),
              ],
            ),
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
