import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/order/models/order_payload.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class OrderNotifier extends StateNotifier<IsLoading> {
  OrderNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future placeOrder({
    required BuildContext context,
    required List<OrderPayload> orderList,
  }) async {
    if (orderList.isEmpty) return;
    isLoading = true;
    try {
      final user = ref.read(userProvider);

      http.Response response = http.Response("", 500);

      for (OrderPayload orderPayload in orderList) {
        orderPayload.copyWithAddress(user!.address);
        response = await http.post(
            Uri.parse("${Constants.baseUrl}/order/place-order"),
            headers: {...Constants.contentType, "x-auth-token": user.token},
            body: orderPayload.toJson());
      }

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: response,
            onSuccess: () {
              showSnackBar(context, "Order placed");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future cancelOrder(
      {required BuildContext context, required String orderId}) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);
      final res = await http
          .post(Uri.parse("${Constants.baseUrl}/order/cancel-order"), headers: {
        ...Constants.contentType,
        "x-auth-token": user!.token,
      }, body: {
        "orderId": orderId,
      });

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Order has been canceled");
            });
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
