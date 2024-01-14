import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/tabs/home/components/categories_list.dart';
import 'package:dibook/view/tabs/home/components/all_product_list.dart';
import 'package:dibook/view/tabs/home/components/category_product_list.dart';
import 'package:dibook/view/tabs/home/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:dibook/view/constants/strings.dart' as categories;

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
              const AllProductList(),
              const SizedBox(height: 30),
              ...List.generate(
                  categories.Strings.categories.length,
                  (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryProductList(
                              category: categories.Strings.categories[index],
                            ),
                            const SizedBox(height: 30),
                          ]))
            ],
          ),
        ),
      ),
    );
  }
}
