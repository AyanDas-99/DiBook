import 'package:dibook/state/sales/providers/all_sales_by_year_provider.dart';
import 'package:dibook/state/sales/utils/calculate_total.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThisYearSales extends ConsumerWidget {
  const ThisYearSales({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<TooltipState> toolTipKey = GlobalKey<TooltipState>();
    final year = DateTime.now().year;

    final sales = ref.watch(allSalesByYearProvider(year));
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 0.5)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: sales.when(
            data: (sales) {
              final total = calculateTotal(sales);
              return Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                key: toolTipKey,
                height: 80,
                message: "${sales.length} book sold on $year",
                textStyle: const TextStyle(color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        spreadRadius: 0.3)
                  ],
                  // border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "This Years Sales",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "\u{20B9} $total",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              );
            },
            error: (e, st) => const Text("Retry"),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
