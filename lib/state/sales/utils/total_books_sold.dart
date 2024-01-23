import 'package:dibook/state/sales/models/sale.dart';

int totalBooksSold(List<Sale> sales) {
  int no = sales.fold(
      0, (previousValue, element) => previousValue + element.soldCount);
  return no;
}
