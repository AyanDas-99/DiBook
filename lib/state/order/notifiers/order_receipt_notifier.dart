import 'dart:convert';
import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class OrderReceiptNotifier extends StateNotifier<Null> {
  OrderReceiptNotifier(this.ref) : super(null);

  final Ref ref;

  Future<String?> buildReceipt(
      {required List<String> orderIds,
      required String paymentMethod,
      required BuildContext context}) async {
    String? receipt;
    try {
      final user = ref.read(userProvider);
      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/order/get-order-receipt"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode({
            'orders': orderIds,
            'paymentMethod': paymentMethod,
          }));

      if (res.statusCode == 200) {
        receipt = res.body;
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }

    return receipt;
  }
}
