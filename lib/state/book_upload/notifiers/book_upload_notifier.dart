import 'dart:io';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/book_upload/models/book_payload.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class BookUploadNotifier extends StateNotifier<IsLoading> {
  BookUploadNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool val) {
    if (mounted) state = val;
  }

  Future<bool> uploadBook(BuildContext context, BookPayload payload) async {
    bool result = false;
    final user = ref.read(userProvider);
    isLoading = true;
    try {
      // Uploading images and getting links
      final cloudinary = CloudinaryPublic('drrrtwtyf', 'qbpqcquc');
      List<String> imageLinks = [];
      for (File image in payload.images) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(image.path,
                folder: "Dibook/books/${payload.name}"));
        imageLinks.add(res.secureUrl);
      }
      payload.copyWithImageLinks(imageLinks);

      // Uploading the book to db
      final res = await http.post(
        Uri.parse("${Constants.baseUrl}/user/upload"),
        headers: {
          ...Constants.contentType,
          "x-auth-token": user!.token,
        },
        body: payload.toJson(),
      );
      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Succesfully uploaded a book");
              result = true;
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    isLoading = false;
    return result;
  }
}
