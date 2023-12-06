import 'dart:convert';

import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dibook/state/auth/constants.dart';

final allOrdersProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  final user = ref.watch(userProvider);
  List<Order> orders = [];
  final res = await http.get(Uri.parse("${Constants.baseUrl}/user/orders"),
      headers: {...Constants.contentType, "x-auth-token": user!.token});

  orders = (jsonDecode(res.body) as List).map((e) => Order.fromMap(e)).toList();
  return orders;
});
