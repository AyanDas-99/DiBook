import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/books/models/book.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final allBooksProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  List<Book> books = [];
  final res = await http.get(Uri.parse("${Constants.baseUrl}/book/all-books"));

  if (res.statusCode == 200) {
    books.addAll((jsonDecode(res.body) as List)
        .map((book) => Book.fromMap(book))
        .toList());

    return books;
  }
  return [];
});
