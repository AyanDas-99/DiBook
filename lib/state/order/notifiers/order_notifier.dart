import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/order/models/order.dart';
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

  Future<List<Order>> placeOrder({
    required BuildContext context,
    required List<OrderPayload> orderList,
  }) async {
    List<Order> orders = [];
    if (orderList.isEmpty) return orders;
    isLoading = true;
    try {
      final user = ref.read(userProvider);

      List<http.Response> responses = [];

      for (OrderPayload orderPayload in orderList) {
        if (orderPayload.address.isEmpty) {
          orderPayload.copyWithAddress(user!.address);
        }

        http.Response response = await http.post(
            Uri.parse("${Constants.baseUrl}/order/place-order"),
            headers: {...Constants.contentType, "x-auth-token": user!.token},
            body: orderPayload.toJson());
        responses.add(response);
      }

      if (context.mounted) {
        for (http.Response res in responses) {
          httpErrorHandler(
              context: context,
              response: res,
              onSuccess: () {
                showSnackBar(context, "Order placed");
                orders.add(Order.fromJson(res.body));
              });
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;
    }

    return orders;
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
