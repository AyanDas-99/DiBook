import 'dart:convert';

import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/cart/models/cart.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final cartProvider = FutureProvider.autoDispose<Cart>((ref) async {
  final user = ref.watch(userProvider);
  final res =
      await http.get(Uri.parse("${Constants.baseUrl}/user/cart"), headers: {
    ...Constants.contentType,
    "x-auth-token": user!.token,
  });

  if (res.statusCode == 200) {
    if (jsonDecode(res.body) == null) {
      // ignore: prefer_const_literals_to_create_immutables
      return Cart(userId: user.id, items: []);
    }
    final cart = Cart.fromJson(res.body);
    return cart;
  } else {
    return Future.error(jsonDecode(res.body));
  }
});
