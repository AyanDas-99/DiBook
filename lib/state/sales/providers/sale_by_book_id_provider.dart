import 'package:dibook/state/sales/models/sale.dart';
import 'package:dibook/state/sales/providers/all_sales_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final saleByBookIdProvider =
    FutureProvider.family.autoDispose<int, String>((ref, String bookId) async {
  List<Sale> sales = [];
  ref.watch(allSalesProvider).whenData((value) => sales = value);
  print(sales);
  List<int> allSales = [0];
  for (var sale in sales) {
    if (sale.bookId == bookId) {
      allSales.add(sale.soldCount);
    }
  }

  return allSales.reduce((value, element) => value + element);
});
