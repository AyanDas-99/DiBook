import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/books/models/book.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final bookByIdProvider =
    FutureProvider.autoDispose.family<Book, String>((ref, bookId) async {
  final res = await http.get(Uri.parse("${Constants.baseUrl}/book/id/$bookId"));

  if (res.statusCode == 200) {
    final book = Book.fromMap(jsonDecode(res.body));
    return book;
  } else {
    return Future.error(jsonDecode(res.body));
  }
});
