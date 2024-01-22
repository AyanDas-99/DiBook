import 'package:dibook/state/sales/models/sale.dart';

int calculateTotal(List<Sale> sales) {
  int total = 0;
  for (var element in sales) {
    total += element.price * element.soldCount;
  }
  return total;
}
