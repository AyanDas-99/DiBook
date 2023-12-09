import 'dart:convert';

import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class UpdateUserNotifier extends StateNotifier<IsLoading> {
  UpdateUserNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future updateUser(
    BuildContext context, {
    String? name,
    String? address,
    String? photoUrl,
  }) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);
      final payload = {};
      if (name != null) {
        payload['name'] = name;
      }
      if (address != null) {
        payload['address'] = address;
      }
      if (photoUrl != null) {
        payload['photo_url'] = photoUrl;
      }

      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/user/update-user"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode(payload));

      if (context.mounted) {
        httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context, "Updates saved");
            ref.read(authStateProvider.notifier).signInWithToken(context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
}
