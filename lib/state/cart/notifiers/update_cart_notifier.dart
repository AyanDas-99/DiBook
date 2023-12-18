import 'dart:convert';

import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/cart/providers/cart_provider.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class UpdateCartNotifier extends StateNotifier<IsLoading> {
  UpdateCartNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  Future addToCart(
      {required BuildContext context, required String bookId}) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);
      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/cart/add-to-cart"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode({"bookId": bookId}));

      if (context.mounted) {
        httpErrorHandler(context: context, response: res, onSuccess: () {});
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;
      ref.invalidate(cartProvider);
    }
  }

  Future removeFromCart(
      {required BuildContext context, required String bookId}) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);
      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/cart/remove-from-cart"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode({"bookId": bookId}));

      if (context.mounted) {
        httpErrorHandler(context: context, response: res, onSuccess: () {});
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;

      ref.invalidate(cartProvider);
    }
  }

  Future deleteFromCart(
      {required BuildContext context, required String bookId}) async {
    isLoading = true;
    try {
      final user = ref.read(userProvider);
      final res = await http.post(
          Uri.parse("${Constants.baseUrl}/cart/delete-from-cart"),
          headers: {...Constants.contentType, "x-auth-token": user!.token},
          body: jsonEncode({"bookId": bookId}));

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              showSnackBar(context, "Deleted from cart");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    } finally {
      isLoading = false;

      ref.invalidate(cartProvider);
    }
  }
}
