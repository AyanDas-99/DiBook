import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/single_book.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  const BooksList({super.key, required this.title, required this.books});
  final String title;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(
            text: '''Results for "$title"''',
            sub: true,
          ),
          const SizedBox(height: 10),
          if (books.isNotEmpty) ...books.map((book) => SingleBook(book)),
          if (books.isEmpty) ...[
            const Center(
              child: Image(image: AssetImage("asset/images/search-icon.png")),
            ),
            const Center(child: Heading(text: "Not found", sub: true))
          ]
        ],
      ),
    ));
  }
}
