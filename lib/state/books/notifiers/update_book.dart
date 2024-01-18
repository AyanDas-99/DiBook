import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class UpdateBookNotifier extends StateNotifier<IsLoading> {
  UpdateBookNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future<bool?> updateBook(Book book, BuildContext context) async {
    isLoading = true;
    bool? success;
    try {
      final user = ref.watch(userProvider);
      var res =
          await http.post(Uri.parse("${Constants.baseUrl}/book/update-book"),
              headers: {...Constants.contentType, "x-auth-token": user!.token},
              body: jsonEncode({
                "bookId": book.bookId,
                "book": book.toMap(),
              }));

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Book updated successfully");
              success = true;
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "Book update failed!");
      }
    } finally {
      isLoading = false;
    }

    return success;
  }

  Future<bool?> deleteBook(Book book, BuildContext context) async {
    isLoading = true;
    bool? success;
    try {
      final user = ref.watch(userProvider);

      // Delete from mongo
      var res = await http.post(
          Uri.parse("${Constants.baseUrl}/book/delete-book"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode({"bookId": book.bookId}));

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Book deleted successfully");
              success = true;
            });
      }

      // Delete from cloudinary
      res = await http.post(Uri.parse("${Constants.baseUrl}/book/delete-asset"),
          headers: {...Constants.contentType, "x-auth-token": user.token},
          body: jsonEncode({"urls": book.images}));

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Book deleted successfully");
              success = true;
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "Could not delete book");
      }
    } finally {
      isLoading = false;
    }
    return success;
  }
}
