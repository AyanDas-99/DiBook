import 'package:dibook/state/sales/models/sale.dart';

int totalSaleOnDay(List<Sale> sales, int date) {
  int total = 0;
  sales = sales.where((element) => element.soldOn.day == date).toList();
  for (var sale in sales) {
    total += sale.price * sale.soldCount;
  }
  return total;
}
