import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/books/models/book.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final categoryBooksProvider = FutureProvider.autoDispose
    .family<List<Book>, String>((ref, category) async {
  List<Book> books = [];
  final res =
      await http.get(Uri.parse("${Constants.baseUrl}/book/category/$category"));

  if (res.statusCode == 200) {
    books.addAll((jsonDecode(res.body) as List)
        .map((book) => Book.fromMap(book))
        .toList());

    return books;
  }
  return Future.error(jsonDecode(res.body));
});
