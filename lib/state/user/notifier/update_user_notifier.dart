import 'package:dibook/state/auth/constants.dart';
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

  Future updateAddress(BuildContext context, String address) async {
    try {
      final user = ref.read(userProvider);
      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/user/update-address"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: {"address", address});

      if (context.mounted) {
        httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context, "Address updated");
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
