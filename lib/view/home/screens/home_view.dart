import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/home/components/categories_list.dart';
import 'package:dibook/view/home/components/product_list.dart';
import 'package:dibook/view/home/constants/strings.dart';
import 'package:dibook/view/searched_books/category_books_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const ProductList(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
