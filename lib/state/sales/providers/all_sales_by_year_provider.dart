import 'package:dibook/state/sales/models/sale.dart';
import 'package:dibook/state/sales/providers/all_sales_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allSalesByYearProvider =
    FutureProvider.family.autoDispose<List<Sale>, int>((ref, int year) async {
  final allSales = ref.watch(allSalesProvider);
  List<Sale> sales = [];
  allSales.whenData((value) => sales = value);
  List<Sale> filteredSale =
      sales.where((element) => element.soldOn.year == year).toList();
  return filteredSale;
});
