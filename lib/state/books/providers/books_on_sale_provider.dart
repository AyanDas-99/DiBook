import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final booksOnSaleProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  final user = ref.watch(userProvider);
  List<Book> books = [];
  final res = await http.get(
      Uri.parse(
        "${Constants.baseUrl}/user/books-on-sale",
      ),
      headers: {
        ...Constants.contentType,
        "x-auth-token": user!.token,
      });

  if (res.statusCode == 200) {
    books.addAll((jsonDecode(res.body) as List)
        .map((book) => Book.fromMap(book))
        .toList());

    return books;
  }
  return [];
});
