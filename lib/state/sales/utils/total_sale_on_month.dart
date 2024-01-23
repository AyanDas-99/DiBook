import 'package:dibook/state/sales/models/sale.dart';

int totalSaleOnMonth(List<Sale> sales, int month) {
  int total = 0;
  sales = sales.where((element) => element.soldOn.month == month).toList();
  for (var sale in sales) {
    total += sale.price * sale.soldCount;
  }
  return total;
}
