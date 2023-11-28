import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/message/models/message_payload.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class UploadMessageNotifier extends StateNotifier<IsLoading> {
  UploadMessageNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future uploadMessage({
    required String message,
    required String bookId,
    required BuildContext context,
    String? replyTo,
  }) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);

      final messagePayload = MessagePayload(
        bookId: bookId,
        userName: user!.name,
        replyTo: replyTo ?? "",
        message: message,
      );

      final res =
          await http.post(Uri.parse("${Constants.baseUrl}/api/message-upload"),
              headers: {
                ...Constants.contentType,
                "x-auth-token": user.token,
              },
              body: messagePayload.toJson());

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Message posted");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    isLoading = false;
  }
}
