import 'dart:convert';

import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/sales/models/sale.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final allSalesProvider = FutureProvider.autoDispose<List<Sale>>((ref) async {
  final user = ref.watch(userProvider);
  List<Sale> sales = [];
  final res = await http.get(Uri.parse("${Constants.baseUrl}/sales/get-sales"),
      headers: {...Constants.contentType, "x-auth-token": user!.token});

  print(jsonDecode(res.body));
  sales = (jsonDecode(res.body) as List).map((e) => Sale.fromMap(e)).toList();
  return sales;
});
