import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/books/providers/all_books_provider.dart';
import 'package:dibook/state/books/providers/category_books_provider.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/tabs/home/components/categories_list.dart';
import 'package:dibook/view/tabs/home/components/all_product_list.dart';
import 'package:dibook/view/tabs/home/components/category_product_list.dart';
import 'package:dibook/view/tabs/home/constants/strings.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:dibook/view/constants/strings.dart' as categories;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final allbooks = ref.watch(allBooksProvider);
      return allbooks.when(
        data: (data) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: Strings.category, sub: true),
                  const CategoriesList(),
                  const SizedBox(height: 20),
                  Heading(text: Strings.top, sub: true),
                  const AllProductList(),
                  const SizedBox(height: 30),
                  ...List.generate(
                      categories.Strings.categories.length,
                      (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryProductList(
                                  category:
                                      categories.Strings.categories[index],
                                ),
                                const SizedBox(height: 30),
                              ]))
                ],
              ),
            ),
          ),
        ),
        loading: () =>
            Center(child: Image.asset("asset/gif/animated_book.gif")),
        error: (error, stackTrace) => InkWell(
          onTap: () {
            ref.invalidate(allBooksProvider);
            ref.invalidate(categoryBooksProvider);
            ref.read(authStateProvider.notifier).signInWithToken(context);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.rotateLeft,
                  color: ThemeConstants.darkGreen,
                ),
                const Heading(text: "Something went wrong")
              ],
            ),
          ),
        ),
      );
    });
  }
}
